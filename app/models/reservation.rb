class Reservation < ActiveRecord::Base
   belongs_to :booking
   belongs_to :machine

   
   # FIXME: should validate that the machine is free?
   # or should this be handled in the bookings controller, because it weares
   # the date/time info?
#   accepts_nested_attributes_for :booking
end
