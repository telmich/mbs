class GesamtsController < ApplicationController
  # GET /gesamts
  # GET /gesamts.xml
  def index
    @gesamts = Gesamt.all
    @teile1 = Teil1.all
    @teile2 = Teil2.all 
    @machinen = Machine.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gesamts }
    end
  end

  # GET /gesamts/1
  # GET /gesamts/1.xml
  def show
    @gesamt = Gesamt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gesamt }
    end
  end

  # GET /gesamts/new
  # GET /gesamts/new.xml
  def new
    @gesamt = Gesamt.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gesamt }
    end
  end

  # GET /gesamts/1/edit
  def edit
    @gesamt = Gesamt.find(params[:id])
  end

  # POST /gesamts
  # POST /gesamts.xml
  def create
    @gesamt = Gesamt.new(params[:gesamt])
    @teil1 = Teil1.create(params[:gesamt])
    @teil2 = Teil2.create(params[:gesamt])

    respond_to do |format|
      if @gesamt.save
        format.html { redirect_to(@gesamt, :notice => 'Gesamt was successfully created.') }
        format.xml  { render :xml => @gesamt, :status => :created, :location => @gesamt }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gesamt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gesamts/1
  # PUT /gesamts/1.xml
  def update
    @gesamt = Gesamt.find(params[:id])

    respond_to do |format|
      if @gesamt.update_attributes(params[:gesamt])
        format.html { redirect_to(@gesamt, :notice => 'Gesamt was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gesamt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gesamts/1
  # DELETE /gesamts/1.xml
  def destroy
    @gesamt = Gesamt.find(params[:id])
    @gesamt.destroy

    respond_to do |format|
      format.html { redirect_to(gesamts_url) }
      format.xml  { head :ok }
    end
  end
end
