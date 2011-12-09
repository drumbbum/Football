class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :admin?
  helper_method :has_profile?
  helper_method :has_league?
  helper_method :league_admin?
  helper_method :current_league
  helper_method :picks_remaining
  helper_method :need_profile!
  helper_method :need_league!
  helper_method :weekly_picks
  helper_method :get_matchup
  helper_method :set_current_league

  private

  def admin?(league)
    if current_user && league
      league.admins.include?(current_user.profile)
    end
  end

  def has_profile?
    current_user.profile
  end
  
  def has_league?
    if id = user_session["league_id"]
      id
    elsif has_profile?
      if leagues = current_user.profile.leagues
        if league = leagues.first
          user_session["league_id"] ||= league.id
        end
      end
    end    
  end
  
  def set_current_league(league_id)
    user_session["league_id"] = league_id
  end
  
  def current_league
    if id = has_league?
      League.find_by_id(id)
    end
  end
  
  def league_admin?
    admin?(current_league)
  end

  ## PaidPicks are the total amount of picks each week
  ## This will be decremented with losses
  
  def weekly_picks(profile, week)
    profile.picks & Pick.find_all_by_week(week)
  end

  def picks_remaining(week)
    unless week.nil?      
      picksLeft = current_user.profile ? current_user.profile.picks_left(current_league) : 0
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
      flash[:notice] = "Setup Profile"
      redirect_to new_profile_path
      false
    end
  end
  
  def need_league!
    unless has_league?
      flash[:notice] = "First you must Join a League"
      redirect_to new_membership_path
      false
    end
  end
  
  def get_matchup(week, team_id)
    @matchup = Matchup.find_by_week_and_home(week, team_id)
    @matchup ||= Matchup.find_by_week_and_away(week, team_id)
  end

end