class AdminController < ApplicationController
  before_filter :need_profile!
  def tools
     respond_to do |format|
        format.html # tools.html.erb
        format.xml  { render :xml => @picks }
      end
  end
end
