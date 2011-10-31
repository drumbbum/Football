class Profile < ActiveRecord::Base
  has_many :comments
  has_many :picks
  belongs_to :league
  
  validates_presence_of :first, :last
  
  def picks_left
    total = self.num_of_picks
    picks = self.picks
    picks.each do |pick|
      if pick.has_winner?
        unless pick.good_pick?
          total -= 1
        end
      end
    end
    total
  end
end
