class Teil1sController < ApplicationController
  # GET /teil1s
  # GET /teil1s.xml
  def index
    @teil1s = Teil1.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teil1s }
    end
  end

  # GET /teil1s/1
  # GET /teil1s/1.xml
  def show
    @teil1 = Teil1.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @teil1 }
    end
  end

  # GET /teil1s/new
  # GET /teil1s/new.xml
  def new
    @teil1 = Teil1.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @teil1 }
    end
  end

  # GET /teil1s/1/edit
  def edit
    @teil1 = Teil1.find(params[:id])
  end

  # POST /teil1s
  # POST /teil1s.xml
  def create
    @teil1 = Teil1.new(params[:teil1])

    respond_to do |format|
      if @teil1.save
        format.html { redirect_to(@teil1, :notice => 'Teil1 was successfully created.') }
        format.xml  { render :xml => @teil1, :status => :created, :location => @teil1 }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @teil1.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teil1s/1
  # PUT /teil1s/1.xml
  def update
    @teil1 = Teil1.find(params[:id])

    respond_to do |format|
      if @teil1.update_attributes(params[:teil1])
        format.html { redirect_to(@teil1, :notice => 'Teil1 was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @teil1.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teil1s/1
  # DELETE /teil1s/1.xml
  def destroy
    @teil1 = Teil1.find(params[:id])
    @teil1.destroy

    respond_to do |format|
      format.html { redirect_to(teil1s_url) }
      format.xml  { head :ok }
    end
  end
end
