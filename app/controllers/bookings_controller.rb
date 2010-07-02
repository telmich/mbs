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
    @machine_types = MachineType.all
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
  end

   # POST /bookings
   # POST /bookings.xml
   def create
      @booking = Booking.new(params[:booking])
      @machines = Machine.all
      @machine_types = MachineType.all
      @booking_machines = params[:booking][:reservations_attributes]
      @last_conflicting_booking_date = nil
      @valid_booking = true
      @nodes_count = params[:booking][:nodes_count]
      @hints = []
      @machines_to_book = []

   # { "ikr01" => [...] }

      if @nodes_count.nil?
         @booking.errors[:base] << "No machines selected (lower form)"
      else
         # Find machines to reserve
         @nodes_count.each_pair do |type, count|
            typename = MachineType.find(type).name

            puts "Searching " + count.to_s + " " + typename + " machines"

            count = count.to_i
            all_machines = MachineType.find(type).machines

            if count > all_machines.count
               @booking.errors[:base] << "Trying to book more " + typename + "s than existing."
            else

               reservable_machines_count = 0
               all_machines.each do |machine|
                  break if count == reservable_machines_count

                  if machine.is_free? @booking.begin, @booking.end
                     puts "Adding machine " + machine.name + "for " + MachineType.find(type).name
                     reservable_machines_count += 1
                     @machines_to_book << { :machine_id => machine.id }
                  end

               end

               if count != reservable_machines_count
                  @booking.errors[:base] << "Only " + reservable_machines_count.to_s + " " + MachineType.find(type).name + "(s) available at the choosen date."
               end

            end
         end
      end

      if @machines_to_book.empty?
         @booking.errors[:base] << "Zero machines selected"
      else
         @booking.reservations_attributes = @machines_to_book
      end

      respond_to do |format|
         if @booking.errors.empty? and @booking.save
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
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to(bookings_url) }
      format.xml  { head :ok }
    end
  end
end
