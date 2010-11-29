class BookingsController < ApplicationController

   @@default_period = 6.days

  # GET /bookings
  # GET /bookings.xml
  def index
    @bookings = Booking.existing

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookings }
    end
  end

  # GET /bookings/dead
  # GET /bookings/dead.xml
  def dead
    @bookings = Booking.dead

    respond_to do |format|
      format.html { render :action => "index" }
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
    @machine_types = MachineType.all
    @booking.begin = DateTime.now
    @booking.end = @booking.begin + @@default_period
    @hints = []

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @booking }
    end
  end

  # GET /bookings/1/edit
  def edit
  end

   # POST /bookings
   # POST /bookings.xml
   def create
      @booking = Booking.new(params[:booking])
      @booking.user_id = session[:user_id]
      @booking.existing = true

      @machines = Machine.all
      @machine_types = MachineType.all

      respond_to do |format|
         if @booking.save
            format.html { redirect_to(@booking, :notice => 'Booking successfully created.') }
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

    @booking.modified_by = session[:user_id]
    @booking.existing = false

    respond_to do |format|
      if @booking.update_attributes(@booking)
        format.html { redirect_to(bookings_url, :notice => 'Booking ' + @booking.id.to_s + ' was successfully deleted.') }
        format.xml  { head :ok }
      else
         # FIXME: do some sensible foo here
        format.html { render :action => "edit" }
        format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
      end
    end
    #respond_to do |format|
    #  format.html { redirect_to(bookings_url) }
    #  format.xml  { head :ok }
    #end
  end
end
