class Pick < ActiveRecord::Base
  belongs_to :profile
  belongs_to :league
  has_one :team
  validates_uniqueness_of :profile_id, :scope => [:team_id, :week], :message => 'Pick Already Selected'
  
  def has_winner?
    @matchup = Matchup.find_by_home_and_week(self.team_id, self.week)
    @matchup ||= Matchup.find_by_away_and_week(self.team_id, self.week)
    if @matchup
      Team.find_by_id(@matchup.winner)
    end
  end
  
  def good_pick?
    if winner = self.has_winner?
      return self.team_id.eql?winner.id
    end
  end
  
end
