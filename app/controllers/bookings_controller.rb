class BookingsController < ApplicationController

   @@default_period = 6.days

  # GET /bookings
  # GET /bookings.xml
  def index
    @bookings = Booking.current
    @btitle = "Current"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookings }
    end
  end

  def deleted
    @bookings = Booking.deleted
    @btitle = "Deleted"

    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @bookings }
    end
  end

  def expired
    @bookings = Booking.expired
    @btitle = "Expired"

    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @bookings }
    end
  end

  def future
    @bookings = Booking.future
    @btitle = "Future"

    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @bookings }
    end
  end

  def specific_machines
    @booking = Booking.new
    @booking.reservations.build
    @booking.begin = DateTime.now
    @booking.end = @booking.begin + @@default_period

    @types = MachineType.all
    @reservations = Reservation.new
    @typelist = {}
    @reservation_index = 0
    @max = 0

    @types.each do |type|
      @typelist[type[:name]] = type.machines
      if @typelist[type[:name]].length > @max
         @max = @typelist[type[:name]].length
      end
    end
      
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @booking }
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

      # setup nodes count
      @nodes_count = params[:booking][:nodes_count]

      puts "session/user: " + @booking.user_id.to_s

      @booking.existing = true

      @machines = Machine.all
      @machine_types = MachineType.all

      # Locate machines, depends on nodes_count=
      @machines_to_book = []

      # book nodes if count is submitted
      if @nodes_count
         @nodes_count.each_pair do |type, count|
            typename = MachineType.find(type).name

            count = count.to_i
            all_machines = MachineType.find(type).machines

            if count > all_machines.count
               @booking.errors[:base] << "Trying to book more " + typename + "s than existing."
            else
               reservable_machines_count = 0 
               all_machines.each do |machine|
                  break if count == reservable_machines_count

                  if machine.is_free?({:begin => @booking.begin, :end => @booking.end})
                     reservable_machines_count += 1
                     @machines_to_book << { :machine_id => machine.id }
                  end
               end 

               if count != reservable_machines_count
                  @booking.errors[:base] << "Only " + reservable_machines_count.to_s + " " + MachineType.find(type).name + "(s) available at the choosen date."

                  # be nice to the user and set the count to what is available
                  @nodes_count[type] = reservable_machines_count
               end
            end
         end

         @booking.reservations_attributes = @machines_to_book
      else
         @booking.errors[:base] << "Zero machines selected"
      end

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
