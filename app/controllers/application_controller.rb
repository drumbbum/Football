class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :league_admin?
  helper_method :has_profile?
  
  private
  
  def league_admin?
    if league_admin
      true
    else
      flash
    end
  end
  
  def league_admin
    if has_profile?
      current_user.profile.league.admin.eql?(current_user.id)
    else
    end
  end
  
  def has_profile?
    current_user.profile
  end
end
