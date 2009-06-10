class StudiosController < ApplicationController
  # GET /studios
  # GET /studios.xml
  def index

    @studios = Studio.paginate(:page => params[:page], :per_page  => 10, :conditions => ['name LIKE ?', "%#{params[:search]}%"])

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.html.erb
      format.xml  { render :xml => @studios }
    end
  end

  # GET /studios/1
  # GET /studios/1.xml
  def show
    @studio = Studio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @studio }
    end
  end

end
