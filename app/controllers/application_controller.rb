class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :league_admin?
  
  private
  
  def league_admin?
    current_user.profile.league.admin.eql?(current_user.id)
  end
end
