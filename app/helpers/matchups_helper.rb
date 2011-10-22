module MatchupsHelper
  def getFullName(id)
    @team = Team.find_by_id(id)
    if @team
      @team.full_name
    end
  end
  
  def selectWinner(id)
    redirect_to :action => "edit", :winner => id
  end
end
