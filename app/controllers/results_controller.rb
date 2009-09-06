class ResultsController < ApplicationController

# select weekends.*, gross, periods from weekends left join results on 
# results.period_id = weekends.id and movie_id = 393 where year = 1982 and 
# week between 30 and 36;

  # GET /results
  # GET /results.xml
  def index
    conditions = {}
    conditions = conditions.merge(:measurable_id => params[:movie_id], :measurable_type => 'Movie') unless params[:movie_id].blank?
    conditions = conditions.merge(:measurable_id => params[:group_id], :measurable_type => 'Group') unless params[:group_id].blank?
    conditions = conditions.merge(:country_id => params[:country_id]) unless params[:country_id].blank?
    conditions = conditions.merge(:period_id => params[:weekend_id], :period_type => 'Weekend') unless params[:weekend_id].blank?

    @movie = Movie.find(params[:movie_id]) unless params[:movie_id].blank?

    @results = Result.paginate(:include => [:measurable, :country, :period],
    :conditions => conditions, :page => params[:page], :per_page  => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.html.erb
      format.xml  { render :xml => @results }
    end
  end

  # GET /results/1
  # GET /results/1.xml
  def show
    @result = Result.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @result }
    end
  end

end
