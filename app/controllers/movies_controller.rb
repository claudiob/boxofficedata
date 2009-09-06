class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.xml
  
  def index
    @title = "Access movie incomes"
    if !params[:group_id].blank?
      @group = Group.find(params[:group_id])
      scoped_movies = @group.movies
    else
      conditions  = []
      arguments = {}
      unless params[:search].blank?
        conditions << 'title LIKE :title'
        arguments[:title] = "%#{params[:search]}%"
        @title = "Movie titled '#{params[:search]}'"
      end
      unless params[:studio_id].blank?
        conditions << 'studio_id = :studio_id'
        arguments[:studio_id] = params[:studio_id]
      end
      unless params[:genre_id].blank?
        conditions << 'genre_id = :genre_id'
        arguments[:genre_id] = params[:genre_id]
      end
      unless params[:rating_id].blank?
        conditions << 'rating_id = :rating_id'
        arguments[:rating_id] = params[:rating_id]
      end
      all_conditions = conditions.join(' AND ')    
      scoped_movies = Movie.scoped(:conditions => [all_conditions, arguments])
    end
    @movies = scoped_movies.paginate(:include => [:genre, :studio, :rating],
      :page => params[:page], :per_page  => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  # PUT /movies
  # PUT /movies.xml
  def import
    call_rake :import_movies

    respond_to do |format|
      flash[:notice] = 'Movies are being imported.'
      format.html { redirect_to(movies_url) }
      format.xml  { head :ok }
    end
  end


  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id], :include => [:genre, :studio, :rating])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end

end
