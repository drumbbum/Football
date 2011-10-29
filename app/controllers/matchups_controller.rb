class MatchupsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /matchups
  # GET /matchups.xml
  def index
    # Should be Current_Week
    @week_num = params[:week_num] ? params[:week_num] : 1
    @matchups = Matchup.find_all_by_week(@week_num)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @matchups }
    end
  end

  # GET /matchups/1
  # GET /matchups/1.xml
  def show
    @matchup = Matchup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @matchup }
    end
  end

  # GET /matchups/new
  # GET /matchups/new.xml
  def new
    @matchup = Matchup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @matchup }
    end
  end

  # GET /matchups/1/edit
  def edit
    @matchup = Matchup.find(params[:id])
    @winner = params[:winner]
    if @winner
      @selected_winner = Team.find_by_id(@winner)
    end
    @teams = [Team.find_by_id(@matchup.away), Team.find_by_id(@matchup.home)]
  end

  # POST /matchups
  # POST /matchups.xml
  def create
    @matchup = Matchup.new(params[:matchup])

    respond_to do |format|
      if @matchup.save
        format.html { redirect_to(@matchup, :notice => 'Matchup was successfully created.') }
        format.xml  { render :xml => @matchup, :status => :created, :location => @matchup }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @matchup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /matchups/1
  # PUT /matchups/1.xml
  def update
    @matchup = Matchup.find(params[:id])
    if params[:winner]
      @matchup.winner = params[:winner]
    end

    respond_to do |format|
      if @matchup.update_attributes(params[:matchup])
        format.html { redirect_to(:action => "index", :week_num => @matchup.week, :notice => 'Matchup was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @matchup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /matchups/1
  # DELETE /matchups/1.xml
  def destroy
    @matchup = Matchup.find(params[:id])
    @matchup.destroy

    respond_to do |format|
      format.html { redirect_to(matchups_url) }
      format.xml  { head :ok }
    end
  end
end
