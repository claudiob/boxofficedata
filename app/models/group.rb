class Group < ActiveRecord::Base
  has_many :memberships
  has_many :items, :through => :memberships
  has_many :results, :as => :measurable, :order => :periods
  has_many :periods, :through => :results, :source => :period
#  delegate  :movies, :to => :memberships
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  def movies
      movies_to_include = memberships.included.by_movie.collect(&:item_id).compact
      genres_to_include = memberships.included.by_genre.collect(&:item_id).compact
      movies_to_exclude = memberships.excluded.by_movie.collect(&:item_id).compact
      genres_to_exclude = memberships.excluded.by_genre.collect(&:item_id).compact
      return if movies_to_include.nil? and genres_to_include.nil?
      
      conditions =  "(FALSE"
      params = []
      unless movies_to_include.empty?
        conditions << " || id IN (?)"
        params << movies_to_include
      end
      unless genres_to_include.empty?
        conditions << " || genre_id IN (?)"
        params << genres_to_include
      end
      conditions << ")"
      unless movies_to_exclude.empty?
        conditions << " && id NOT IN (?)" 
        params << movies_to_exclude
      end
      unless genres_to_exclude.empty?
        conditions << " && genre_id NOT IN (?)" 
        params << genres_to_exclude
      end
      params.insert(0, conditions)
      
      Movie.scoped(:conditions => params)
  end
  
  def calculate_results(max_periods = 1000, min_theaters = 0)
    movies = self.movies.all(:include => :results)
    all_results = movies.collect do |movie|
      movie.wide_results(min_theaters = min_theaters, max_periods = max_periods)
    end
    max_periods = all_results.collect(&:size).max
    (0..max_periods-1).collect do |i|
      mean_gross = all_results.collect{|x| x[i].gross unless x[i].nil?}.compact.mean
      mean_position = all_results.collect{|x| x[i].position unless x[i].nil?}.compact.mean
      mean_cumulative = all_results.collect{|x| x[i].cumulative unless x[i].nil?}.compact.mean
      mean_theaters = all_results.collect{|x| x[i].theaters unless x[i].nil?}.compact.mean
      {:group => self, :period_type => "Weekend", :position => (mean_position.nan? ? 0 : mean_position), :gross => (mean_gross.nan? ? 0 : mean_gross), :cumulative => (mean_cumulative.nan? ? 0 : mean_cumulative), :theaters => (mean_theaters.nan? ? 0 : mean_theaters), :periods => i + 1}
    end
  end


end
