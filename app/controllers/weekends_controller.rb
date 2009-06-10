class WeekendsController < ApplicationController
  # GET /weekends
  # GET /weekends.xml
  def index
    @weekends = Weekend.paginate(:page => params[:page], :per_page  => 10)

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

end
