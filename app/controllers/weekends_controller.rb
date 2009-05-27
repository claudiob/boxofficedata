class WeekendsController < ApplicationController
  # GET /weekends
  # GET /weekends.xml
  def index
    @weekends = Weekend.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weekends }
    end
  end

  # GET /weekends/1
  # GET /weekends/1.xml
  def show
    @weekend = Weekend.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @weekend }
    end
  end

  # GET /weekends/new
  # GET /weekends/new.xml
  def new
    @weekend = Weekend.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @weekend }
    end
  end

  # GET /weekends/1/edit
  def edit
    @weekend = Weekend.find(params[:id])
  end

  # POST /weekends
  # POST /weekends.xml
  def create
    @weekend = Weekend.new(params[:weekend])

    respond_to do |format|
      if @weekend.save
        flash[:notice] = 'Weekend was successfully created.'
        format.html { redirect_to(@weekend) }
        format.xml  { render :xml => @weekend, :status => :created, :location => @weekend }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weekend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weekends/1
  # PUT /weekends/1.xml
  def update
    @weekend = Weekend.find(params[:id])

    respond_to do |format|
      if @weekend.update_attributes(params[:weekend])
        flash[:notice] = 'Weekend was successfully updated.'
        format.html { redirect_to(@weekend) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weekend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weekends/1
  # DELETE /weekends/1.xml
  def destroy
    @weekend = Weekend.find(params[:id])
    @weekend.destroy

    respond_to do |format|
      format.html { redirect_to(weekends_url) }
      format.xml  { head :ok }
    end
  end
end
