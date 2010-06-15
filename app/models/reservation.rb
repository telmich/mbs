class Reservation < ActiveRecord::Base
   belongs_to :booking
   belongs_to :machine
end
