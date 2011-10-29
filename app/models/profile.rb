class Profile < ActiveRecord::Base
  has_many :comments
  has_many :picks
  belongs_to :league
  
  validates_presence_of :first, :last
end
