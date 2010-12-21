class Reservation < ActiveRecord::Base
   belongs_to :booking
   belongs_to :machine

#   accepts_nested_attributes_for :booking
end
