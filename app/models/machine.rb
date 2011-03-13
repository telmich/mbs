class Machine < ActiveRecord::Base

   belongs_to  :machine_status
   belongs_to  :machine_type
   has_many    :reservations, :dependent => :destroy
   has_many    :bookings, :through => :reservations

   validates :name, :uniqueness => true, :presence => true
   validates_associated :machine_type
   validates_associated :machine_status


   def is_booked?(dates)
      booked = nil

      bookings.each do |booking|
         # Old code: to check bookings
         # if (booking.begin <= dates[:begin] and booking.end > dates[:begin]) or
         #     (dates[:end] > booking.begin and dates[:end] <= booking.end)

      # Given:
      #  - begin and end of requested booking (dates[:begin], dates[:end]
      #  - begin and end of all existing bookings for the machine
      #  - new begin may be at the same time old expires (i.e. begin_new == end_old)
      #
      # Searched:
      # - any booking conflict
      #
      # Idea:
      #
      # - Does the new booking begin after our end?
         if (dates[:begin] >= booking.end)
            #
            #  yes: no conflict possible with this booking
            #
            next
         else
         #
         # no: the booking can conflict with the current one
         #

            #
            # Does the booking end before our begin?
            #
            if (dates[:end] <= booking.begin)
               #
               #  yes: no conflict possible with this booking
               #
               next
            else
               #
               #  no: new one begins before our end and
               #      new ones ends after our begin
               #      -----> conflict
               #
               
               # Verify that the booking still exists (i.e. not deleted)
               if booking.existing?
                  booked = booking
                  break
               end
            end
         end
      end

      booked
   end

   def is_free?(dates)
      if machine_status == MachineStatus.find_by_name("bookable")
         is_booked?(dates) ? false : true
      else
         false
      end
   end

   def used_by
      booking = is_booked? Booking.now

      if booking
         booking.user.name
      end
   end

   def general_purpose?
      machine_status == MachineStatus.find_by_name("general purpose")
   end

   # listing all general purpose - FIXME: why not scope?
   def Machine.general_purpose
      list = []
      Machine.all.each do |m|
         m.general_purpose? and list << m
      end

      list
   end

end
