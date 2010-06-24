class MachineReservationController < ApplicationController
   def create
      @booking = Booking.new
      @hints = []
      @machines = Machine.all
      @machine_types = MachineType.all
   
   end

end
