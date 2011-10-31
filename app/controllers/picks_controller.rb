class PicksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :need_profile!
  before_filter :pick_deadline, :only => [:new, :destroy]
  
  # GET /picks
  # GET /picks.xml
  def index
    # Should be Current_Week
    @week_num = params[:week_num] ? params[:week_num] : 1
    @matchups = Matchup.find_all_by_week(@week_num).sort_by &:time
    @picks = []
    
    if has_profile?  
      @picks = Pick.find_all_by_profile_id_and_week(current_user.profile.id, @week_num)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @picks }
    end
  end

  # GET /picks/1
  # GET /picks/1.xml
  def show
    @pick = Pick.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pick }
    end
  end

  # GET /picks/new
  # GET /picks/new.xml
  def new
    
    unless picks_remaining(params[:week]) > 0
      flash[:alert] = 'You are out of picks!'
      redirect_to(:action => 'index', :week_num => params[:week])
      return
    end
    
    @pick = Pick.new
    @pick.profile_id = current_user.profile.id
    @pick.week = params[:week]
    @pick.team_id = params[:team_id]

    respond_to do |format|
      if @pick.save
        format.html { redirect_to(:action => 'index', :week_num => @pick.week, :notice => 'Pick was successful, Good Luck!') }
        format.xml  { render :xml => @pick, :status => :created, :location => @pick }
      else
        flash[:alert] = @pick.errors.values.first ? @pick.errors.values.first.first : "Error Saving"
        format.html { redirect_to :action => "index", :week_num => @pick.week}
        format.xml  { render :xml => @pick.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /picks/1/edit
#  def edit
#    @pick = Pick.find(params[:id])
#  end

  # POST /picks
  # POST /picks.xml
#  def create
#    @pick = Pick.new(params[:pick])
#
#    respond_to do |format|
#      if @pick.save
#        format.html { redirect_to(@pick, :notice => 'Pick was successfully created.') }
#        format.xml  { render :xml => @pick, :status => :created, :location => @pick }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @pick.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # PUT /picks/1
  # PUT /picks/1.xml
#  def update
#    @pick = Pick.find(params[:id])
#
#    respond_to do |format|
#      if @pick.update_attributes(params[:pick])
#        format.html { redirect_to(@pick, :notice => 'Pick was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @pick.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /picks/1
  # DELETE /picks/1.xml
  def destroy
    @pick = Pick.find(params[:id])
    @pick.destroy

    respond_to do |format|
      format.html { redirect_to(:action => 'index', :week_num => @pick.week, :notice => 'Pick was removed') }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def pick_deadline
    if params[:week]
      @matchup = get_matchup(params[:week], params[:team_id])
    else
      @pick = Pick.find(params[:id])
      @matchup = get_matchup(@pick.week, @pick.team_id)
    end
    unless @matchup.time.future?
      flash[:alert] = 'Too late!'
      redirect_to(:action => 'index', :week_num => @matchup.week)
    end
  end
  
end
