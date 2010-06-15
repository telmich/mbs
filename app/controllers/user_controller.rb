class UserController < ApplicationController
  def index
    @machines = Machine.all
    @reservations = Reservation.all
  end

end
