class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :league_admin?
  helper_method :has_profile?
  helper_method :picks_remaining
  helper_method :need_profile!
  helper_method :weekly_picks
  helper_method :get_matchup

  private

  def league_admin?
    if league_admin
      true
    end
  end

  def league_admin
    if has_profile?
      current_user.profile.league.admin.eql?(current_user.id)
    end
  end

  def has_profile?
    current_user.profile
  end

  ## PaidPicks are the total amount of picks each week
  ## This will be decremented with losses
  
  def weekly_picks(profile, week)
    profile.picks & Pick.find_all_by_week(week)
  end

  def picks_remaining(week)
    unless week.nil?      
      picksLeft = current_user.profile ? current_user.profile.picks_left : 0
      takenPicks = current_user.profile ? current_user.profile.picks & Pick.find_all_by_week(week) : []
      remaining = picksLeft - takenPicks.size
      if remaining < 0
        0
      else
        remaining
      end 
    end
  end

  def need_profile!
    unless has_profile?
      flash[:alert] = "Setup Profile"
      redirect_to new_profile_path
      false
    end
  end
  
  def get_matchup(week, team_id)
    @matchup = Matchup.find_by_week_and_home(week, team_id)
    @matchup ||= Matchup.find_by_week_and_away(week, team_id)
  end

end