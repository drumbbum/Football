class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :need_profile!
#  before_filter :league_admin?
  def tools
     respond_to do |format|
        format.html # tools.html.erb
        format.xml  { render :xml => @picks }
      end
  end
end
