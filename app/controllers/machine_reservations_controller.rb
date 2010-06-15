class MachineReservationsController < ApplicationController

   def index
      @bookings = Booking.all
      @machines = Machine.all

      @br = {}

      @bookings.each do |booking|
         @br[booking.id] = Reservation.find_all_by_booking_id(booking.id)
      end
   end

  def show
  end

  def create
  end

end
