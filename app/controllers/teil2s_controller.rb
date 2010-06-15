class Teil2sController < ApplicationController
  # GET /teil2s
  # GET /teil2s.xml
  def index
    @teil2s = Teil2.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teil2s }
    end
  end

  # GET /teil2s/1
  # GET /teil2s/1.xml
  def show
    @teil2 = Teil2.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @teil2 }
    end
  end

  # GET /teil2s/new
  # GET /teil2s/new.xml
  def new
    @teil2 = Teil2.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @teil2 }
    end
  end

  # GET /teil2s/1/edit
  def edit
    @teil2 = Teil2.find(params[:id])
  end

  # POST /teil2s
  # POST /teil2s.xml
  def create
    @teil2 = Teil2.new(params[:teil2])

    respond_to do |format|
      if @teil2.save
        format.html { redirect_to(@teil2, :notice => 'Teil2 was successfully created.') }
        format.xml  { render :xml => @teil2, :status => :created, :location => @teil2 }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @teil2.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /teil2s/1
  # PUT /teil2s/1.xml
  def update
    @teil2 = Teil2.find(params[:id])

    respond_to do |format|
      if @teil2.update_attributes(params[:teil2])
        format.html { redirect_to(@teil2, :notice => 'Teil2 was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @teil2.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /teil2s/1
  # DELETE /teil2s/1.xml
  def destroy
    @teil2 = Teil2.find(params[:id])
    @teil2.destroy

    respond_to do |format|
      format.html { redirect_to(teil2s_url) }
      format.xml  { head :ok }
    end
  end
end
