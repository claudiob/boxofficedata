class GroupsController < ApplicationController

  def average_gross
    @group = Group.find(params[:id])
    max_periods = params[:points].blank? ? 10 : params[:points].to_i
    min_theaters = params[:wide].blank? ? 1000 : params[:wide].to_i
    @results = @group.calculate_results(max_periods = max_periods, min_theaters = min_theaters)
    
    # All the following respond_to will be DRYed with the grosses_controller

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
      format.line  { 
        g = Gruff::Line.new # ("#{30*@results.size}x600")
        g.title = "U.S. Weekend Gross (average)"
        g.round_maximum_value = true
        g.data @group.name, @results.collect{|res| res[:gross]}
        (1..@results.size).each do |period| g.labels[period-1] = period.to_s end
        g.minimum_value = 0
#        g.maximum_value = 54000000
        send_data g.to_blob('gif'), :disposition => 'inline', :type => 'image/gif' 
      }

    end
  end

  # GET /groups
  # GET /groups.xml
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to(@group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(@group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end
end
