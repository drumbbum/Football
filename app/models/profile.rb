class Profile < ActiveRecord::Base
  has_many :comments
  has_many :picks
  belongs_to :league
  
end
