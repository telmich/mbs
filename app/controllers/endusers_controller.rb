class EndusersController < ApplicationController
  # GET /endusers
  # GET /endusers.xml
  def index
    @endusers = Enduser.all
    @machines = Machine.all
    @reservations = Reservation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @endusers }
    end
  end

  # GET /endusers/1
  # GET /endusers/1.xml
  def show
    @enduser = Enduser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @enduser }
    end
  end

  # GET /endusers/new
  # GET /endusers/new.xml
  def new
    @enduser = Enduser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @enduser }
    end
  end

  # GET /endusers/1/edit
  def edit
    @enduser = Enduser.find(params[:id])
  end

  # POST /endusers
  # POST /endusers.xml
  def create
    @enduser = Enduser.new(params[:enduser])
    @user_id = User.where(:name => params[:user_id])
    @machine_ids = []
    @machine_ids << params[:machine_ids]

    @machine_ids.each do |machine|
      Machine.find(machine)
   end




    respond_to do |format|
      if @enduser.save
        format.html { redirect_to(@enduser, :notice => 'Enduser was successfully created.') }
        format.xml  { render :xml => @enduser, :status => :created, :location => @enduser }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @enduser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /endusers/1
  # PUT /endusers/1.xml
  def update
    @enduser = Enduser.find(params[:id])

    respond_to do |format|
      if @enduser.update_attributes(params[:enduser])
        format.html { redirect_to(@enduser, :notice => 'Enduser was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @enduser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /endusers/1
  # DELETE /endusers/1.xml
  def destroy
    @enduser = Enduser.find(params[:id])
    @enduser.destroy

    respond_to do |format|
      format.html { redirect_to(endusers_url) }
      format.xml  { head :ok }
    end
  end
end
