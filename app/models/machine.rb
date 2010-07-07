class Machine < ActiveRecord::Base
   validates :name, :uniqueness => true, :presence => true

   has_many :reservations, :dependent => :destroy
   belongs_to :machine_type

   validates_associated :machine_type

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
            puts name + " has a reservation for " + dates[:begin].to_s
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
      else
         ""
      end
      
   end

end
