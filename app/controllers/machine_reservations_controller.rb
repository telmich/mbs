class MachineReservationsController < ApplicationController

   def index
      @bookings = Booking.all

      @br = []

      @bookings.each do |booking|
         Reservation.find_all_by_booking_id(booking.id).each do |reservation|
            tmp = {}
            tmp[:id] = booking[:id]
            tmp[:username] = User.find(booking[:user_id]).name
            tmp[:reservation] = reservation
            tmp[:machine_name] = Machine.find(reservation[:machine_id]).title

            @br << tmp
         end
      end
   end

  def new
      @machines = Machine.all
      @date_default_start = Date.today
      @date_default_end = Date.today+6

  end

  def edit
  end

  def show
  end

  def create

#      @booking = Booking.new
      @user = User.find_by_name(params[:user][:name])

      if ! @user
         respond_to do |format|
            format.html { render :action => "error" }
            format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
         end
         return
      end

      @booking = Booking.create({ :user_id => @user.id })

      @date_start =  DateTime.civil(y=params[:date_start][:year].to_i,
                           m=params[:date_start][:month].to_i,
                           d=params[:date_start][:day].to_i,
                           h=0, min=0, s=0, of=0)

      @date_end =  DateTime.civil(y=params[:date_end][:year].to_i,
                           m=params[:date_end][:month].to_i,
                           d=params[:date_end][:day].to_i,
                           h=0, min=0, s=0, of=0)

#      @booking.user_id = User.find_by_name(params[:user][:name]).id

      # fail if we cannot save
      if ! @booking.save
         respond_to do |format|
            format.html { render :action => "index" }
            format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
         end
         return
      end

      @machines = params[:bookings][:machine_ids]

      @machines.each do |machine|
         m = Reservation.create ({
            :machine_id => machine,
            :user_id => @user.id,
            :booking_id => @booking.id,
            :begin => @date_start,
            :end => @date_end,
         })  
      end

      respond_to do |format|
         format.html { redirect_to :action => "index", :notice => 'Machine reservation was successfully created.' }
         format.xml  { render :xml => @booking, :status => :created, :location => @booking } 
      end

  end

end
