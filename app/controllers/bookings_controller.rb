class BookingsController < ApplicationController
  # GET /bookings
  # GET /bookings.xml
  def index
    @bookings = Booking.all
    @machines = Machine.all
    @machines = Machine.all

    @booking_reservations = {}

   if @bookings != nil
      @bookings.each do |booking|
#         @booking_reservations[booking.id][:bookings] = Reservation.find_all_by_booking_id(booking.id)
#         @booking_reservations[booking.id][:bookings] = Reservation.find_all_by_booking_id(booking.id)
      end
   end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookings }
    end
  end

  # GET /bookings/1
  # GET /bookings/1.xml
  def show
    @booking = Booking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @booking }
    end
  end

  # GET /bookings/new
  # GET /bookings/new.xml
  def new
    @booking = Booking.new
    @booking.reservations.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @booking }
    end
  end

  # GET /bookings/1/edit
  def edit
    @booking = Booking.find(params[:id])
  end

  # POST /bookings
  # POST /bookings.xml
  def create
    @booking = Booking.new(params[:booking])
    @user = User.find_by_name(params[:user][:name])
    puts @user.id, "\n"

    #@booking.user_id = @user.id
    @booking.user_id = User.find_by_name(params[:user][:name]).id

    @machines = params[:bookings][:machine_ids]

    @machines.each do |machine|
      m = Reservation.create ({
         :machine_id => machine,
         :user_id => @user.id,
         :booking_id => @booking.id
      })
   end

    respond_to do |format|
      if @booking.save
        format.html { redirect_to(@booking, :notice => 'Booking was successfully created.') }
        format.xml  { render :xml => @booking, :status => :created, :location => @booking }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bookings/1
  # PUT /bookings/1.xml
  def update
    @booking = Booking.find(params[:id])

    respond_to do |format|
      if @booking.update_attributes(params[:booking])
        format.html { redirect_to(@booking, :notice => 'Booking was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.xml
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to(bookings_url) }
      format.xml  { head :ok }
    end
  end
end
