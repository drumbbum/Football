class Membership < ActiveRecord::Base
  belongs_to :profile
  belongs_to :league
end
