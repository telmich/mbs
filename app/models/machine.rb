class Machine < ActiveRecord::Base
   validates :title, :uniqueness => true

   has_many :reservations, :dependent => :destroy
   belongs_to :machine_type

   def is_free?(d_begin, d_end)
      @free = true

      reservations.each do |existing_reservation|
         if existing_reservation.booking.begin <= d_begin and existing_reservation.booking.end > d_begin
            @free = false
            break
         end 
      end 
      @free
   end

end
