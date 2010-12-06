class Machine < ActiveRecord::Base
   validates :name, :uniqueness => true, :presence => true

   has_many    :reservations, :dependent => :destroy
   has_many    :bookings, :through => :reservations
   belongs_to  :machine_type
   validates_associated :machine_type

   belongs_to  :machine_status

   # need to remove this, to make it work with nested attributes
   # from machine_type!
#   validates :machine_type_id, :presence => true

   def has_reservation?(dates)
      reservation = nil

      reservations.each do |existing_reservation|
         if (existing_reservation.booking.begin <= dates[:begin] and
             existing_reservation.booking.end > dates[:begin]) or
             (dates[:end] > existing_reservation.booking.begin and
              dates[:end] <= existing_reservation.booking.end)

            reservation = existing_reservation
            break
         end
      end

      reservation
   end

   def is_free?(dates)
      has_reservation?(dates) ? false : true
   end

   def used_by
      reservation = has_reservation? Booking.now

      if reservation
         reservation.booking.user.name
      end
      
   end

end
