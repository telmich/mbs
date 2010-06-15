class UserController < ApplicationController
  def index
    @machines = Machine.all
    @reservations = Reservation.all
    @userid = -1
  end

end
