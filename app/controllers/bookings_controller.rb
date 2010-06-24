class BookingsController < ApplicationController
   @@default_period = 6

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
   puts "Entered in new here"
    @booking = Booking.new
    @booking.reservations.build
    @machines = Machine.all
    @booking.begin = Date.today
    @booking.end = @booking.begin.to_datetime.next_day @@default_period
    @hints = []

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
    @last_conflicting_booking_date = nil
    @valid_booking = true
    @hints = []

    # { "ikr01" => [...] }

   # Find all machines we try to book
   if ! @booking_machines
      @valid_booking = false
      @booking.errors[:base] << "No machines selected"
   else
      @booking_machines.each do |booking_machine|
         machine_test = Machine.find(booking_machine[:machine_id])
         
         # Find all reservations on all machines we try to book
         machine_test.reservations.each do |existing_reservation|
            # Existing reservation conflicts with booking
            if existing_reservation.booking.begin <= @booking.begin and
               existing_reservation.booking.end > @booking.begin

               @booking.errors[:base] <<
                  "Conflicting booking " +
                  existing_reservation.booking.id.to_s +
                  " with reservation for " +
                  machine_test.title +
                  " (" +
                  existing_reservation.booking.begin.to_s +
                  " - " +
                  existing_reservation.booking.end.to_s +
                  ")"
               @valid_booking = false

               # Remember the latest reservation time and set as begin on repost
               if ! @last_conflicting_booking_date
                  @last_conflicting_booking_date = existing_reservation.booking.end
               else
                  if @last_conflicting_booking_date < existing_reservation.booking.end
                     @last_conflicting_booking_date = existing_reservation.booking.end
                  end
               end
            end
         end
      end
   end

   # Be smart, set begin and end after last reservation
   if @last_conflicting_booking_date
      @booking.begin = @last_conflicting_booking_date.to_datetime.next_day 1
      @booking.end = @booking.begin.next_day @@default_period
      # FIXME: should be notice
      @hints << "Automatically adjusted begin and end date"
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
