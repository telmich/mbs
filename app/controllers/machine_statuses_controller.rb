class MachineStatusesController < ApplicationController
  # GET /machine_statuses
  # GET /machine_statuses.xml
  def index
    @machine_statuses = MachineStatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @machine_statuses }
    end
  end

  # GET /machine_statuses/1
  # GET /machine_statuses/1.xml
  def show
    @machine_status = MachineStatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @machine_status }
    end
  end

  # GET /machine_statuses/new
  # GET /machine_statuses/new.xml
  def new
    @machine_status = MachineStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @machine_status }
    end
  end

  # GET /machine_statuses/1/edit
  def edit
    @machine_status = MachineStatus.find(params[:id])
  end

  # POST /machine_statuses
  # POST /machine_statuses.xml
  def create
    @machine_status = MachineStatus.new(params[:machine_status])

    respond_to do |format|
      if @machine_status.save
        format.html { redirect_to(@machine_status, :notice => 'Machine status was successfully created.') }
        format.xml  { render :xml => @machine_status, :status => :created, :location => @machine_status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @machine_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /machine_statuses/1
  # PUT /machine_statuses/1.xml
  def update
    @machine_status = MachineStatus.find(params[:id])

    respond_to do |format|
      if @machine_status.update_attributes(params[:machine_status])
        format.html { redirect_to(@machine_status, :notice => 'Machine status was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @machine_status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /machine_statuses/1
  # DELETE /machine_statuses/1.xml
  def destroy
    @machine_status = MachineStatus.find(params[:id])
    @machine_status.destroy

    respond_to do |format|
      format.html { redirect_to(machine_statuses_url) }
      format.xml  { head :ok }
    end
  end
end
