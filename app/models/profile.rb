class Profile < ActiveRecord::Base
  has_many :comments
  has_many :picks
  has_many :memberships, :dependent => :destroy
  has_many :leagues, :through => :memberships
  
  validates_presence_of :first, :last
  
  def league_membership(current_league)
    self.memberships.each do |membership|
      if membership.league_id.eql?(current_league.id)
        return membership
      end
    end
  end
  
  def picks_left(current_league)
    total = self.league_membership(current_league).num_of_picks
    picks = self.picks & current_league.picks
    puts picks
    picks.each do |pick|
      if pick.has_winner?
        puts "Has Winner"
        puts "Good pick? -> #{pick.good_pick?}"
        unless pick.good_pick?
          total -= 1
        end
      end
    end
    total
  end
  
  def full_name
    "#{self.first} #{self.last}"
  end
end
