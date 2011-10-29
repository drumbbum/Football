class PicksController < ApplicationController
  # GET /picks
  # GET /picks.xml
  def index
    # Should be Current_Week
    @week_num = params[:week_num] ? params[:week_num] : 1
    @matchups = Matchup.find_all_by_week(@week_num)
    
    if has_profile?  
      @picks = Pick.find_all_by_profile_id_and_week(current_user.profile.id, @week_num)
    end
    
    @remaining = 
    
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
    @pick = Pick.new
    @pick.profile_id = current_user.id
    @pick.week = params[:week]
    @pick.team_id = params[:team_id]

    respond_to do |format|
      if @pick.save
        format.html { redirect_to(:action => 'index', :week_num => @pick.week, :notice => 'Pick was successful, Good Luck!') }
        format.xml  { render :xml => @pick, :status => :created, :location => @pick }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pick.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /picks/1/edit
  def edit
    @pick = Pick.find(params[:id])
  end

  # POST /picks
  # POST /picks.xml
  def create
    @pick = Pick.new(params[:pick])

    respond_to do |format|
      if @pick.save
        format.html { redirect_to(@pick, :notice => 'Pick was successfully created.') }
        format.xml  { render :xml => @pick, :status => :created, :location => @pick }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pick.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /picks/1
  # PUT /picks/1.xml
  def update
    @pick = Pick.find(params[:id])

    respond_to do |format|
      if @pick.update_attributes(params[:pick])
        format.html { redirect_to(@pick, :notice => 'Pick was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pick.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /picks/1
  # DELETE /picks/1.xml
  def destroy
    @pick = Pick.find(params[:id])
    @pick.destroy

    respond_to do |format|
      format.html { redirect_to(picks_url) }
      format.xml  { head :ok }
    end
  end
  
  def remainingPicks(week)
    if has_profile?
      @picks = Pick.find_all_by_profile_id_and_week(current_user.profile.id, week)
      numOfPicks = current_user.profile.num_of_picks
    end
  end
end