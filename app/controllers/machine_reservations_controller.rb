class MachineReservationsController < ApplicationController

   def index
      @bookings = Booking.all
      @machines = Machine.all

      @br = []

      @bookings.each do |booking|
         #tmp[:booking_ids] = Reservation.find_all_by_booking_id(booking.id)
         Reservation.find_all_by_booking_id(booking.id).each do |reservation|
            tmp = {}
            tmp[:id] = booking[:id]
            tmp[:username] = User.find(booking[:user_id]).name
            tmp[:reservation] = reservation

            @br << tmp
         end
      end
   end

  def new
  end

  def edit
  end

  def show
  end

  def create
      @booking = Booking.new
      @user = User.find_by_name(params[:user][:name])
      @booking.user_id = User.find_by_name(params[:user][:name]).id

      # fail if we cannot save
      if ! @booking.save
         respond_to do |format|
            format.html { render :action => "new" }
            format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
         end
         return
      end

      @machines = params[:bookings][:machine_ids]

      @machines.each do |machine|
         m = Reservation.create ({
            :machine_id => machine,
            :user_id => @user.id,
            :booking_id => @booking.id
         })  
      end

      respond_to do |format|
         # FIXME: find out how to call redirect_to to redirect back
         format.html { redirect_to(@booking, :notice => 'Machine reservation was successfully created.') }
         format.xml  { render :xml => @booking, :status => :created, :location => @booking } 
      end

  end

end
