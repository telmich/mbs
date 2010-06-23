class BookingsController < ApplicationController
  # GET /bookings
  # GET /bookings.xml
  def index
    @bookings = Booking.all

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
    @machines = Machine.all
    @booking.begin = Date.today
    @booking.end = Date.today + 6

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
    @machines = Machine.all
    @booking_machines = params[:booking][:reservations_attributes]
    @last_booking_date = nil

   # check validity of booking dates
   @valid_booking = true
   # Find all machines we try to book
   @booking_machines.each do |booking_machine|
      machine_test = Machine.find(booking_machine[:machine_id])
      
      # Find all reservations on all machines we try to book
      machine_test.reservations.each do |existing_reservation|
         if existing_reservation.booking.end > @booking.begin
            # update latest used
            if @last_booking_date
               if @last_booking_date < existing_reservation.booking.end
                  @last_booking_date = existing_reservation.booking.end
               end
            else
               @last_booking_date = existing_reservation.booking.end
            end
         end
      end
   end

   # Accept only booking end before booking begin
   if @booking.begin >= @booking.end
      @valid_booking = false
      @booking.errors.add(:end, "too early: Must be after begin: " + @booking.begin.to_s )
   end

   if @last_booking_date
      @valid_booking = false
      @booking.errors.add(:begin, "too early: Book after " + @last_booking_date.to_s )
   end

    respond_to do |format|
      if @valid_booking and @booking.save
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
