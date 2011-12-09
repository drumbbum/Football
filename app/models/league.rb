class League < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :profiles, :through => :memberships
  has_many :picks
  
  def admins
    admins = Array.new
    self.memberships.each do |membership|
      if membership.admin
        admins << membership.profile
      end
    end
    return admins
  end
  
end
