class Machine < ActiveRecord::Base
   validates :name, :uniqueness => true, :presence => true

   has_many :reservations, :dependent => :destroy
   belongs_to :machine_type

   validates_associated :machine_type

   # need to remove this, to make it work with nested attributes
   # from machine_type!
#   validates :machine_type_id, :presence => true

   def is_free?(d_begin, d_end)
      free = true

      reservations.each do |existing_reservation|
         if existing_reservation.booking.begin <= d_begin and existing_reservation.booking.end > d_begin
            free = false
            break
         end 
      end 
      free
   end

end
