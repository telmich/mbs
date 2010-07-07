class Machine < ActiveRecord::Base
   validates :name, :uniqueness => true, :presence => true

   has_many :reservations, :dependent => :destroy
   belongs_to :machine_type

   validates_associated :machine_type

   # need to remove this, to make it work with nested attributes
   # from machine_type!
#   validates :machine_type_id, :presence => true

   def has_reservation?(d_begin, d_end)
      reservation = nil

      reservations.each do |existing_reservation|
         if existing_reservation.booking.begin <= d_begin and existing_reservation.booking.end > d_begin
            reservation = existing_reservation
            puts name + " has a reservation for " + d_begin.to_s
            break
         end
      end

      reservation
   end

   def is_free?(d_begin, d_end)
      has_reservation?(d_begin, d_end) ? false : true
   end

   def used_by
      
   end

end
