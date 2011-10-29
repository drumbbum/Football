class Pick < ActiveRecord::Base
  belongs_to :profile
  
  validates_uniqueness_of :profile_id, :scope => [:team_id, :week], :message => 'Pick already Selected'
end
