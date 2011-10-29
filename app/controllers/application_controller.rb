class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :league_admin?
  helper_method :has_profile?
  helper_method :picks_remaining
  helper_method :need_profile!

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

  def picks_remaining(week)
    unless week.nil?
      paidPicks = current_user.profile ? current_user.profile.num_of_picks : 0
      takenPicks = current_user.profile ? current_user.profile.picks & Pick.find_all_by_week(week) : []
      return paidPicks - takenPicks.size
    end
  end

  def need_profile!
    unless has_profile?
      flash[:notice] = "Unauthorized Access"
      redirect_to root_url
      false
    end
  end
end