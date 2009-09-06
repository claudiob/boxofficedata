require 'fastercsv'
class Movie < ActiveRecord::Base
  belongs_to :studio
  belongs_to :genre
  belongs_to :rating
  has_many :results, :as => :measurable, :order => :periods
  has_many :periods, :through => :results, :source => :period
  has_many :memberships, :as => :item
  has_many :groups, :through => :memberships
  
  validates_uniqueness_of :code, :on => :create, :message => "must be unique"
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  
  def name
    title
  end
  
  def print_budget
    "#{self.budget.to_i}M$" if self.budget
  end

  def wide_results(min_theaters = 1000, max_periods=5)
    wide_periods = self.results.select{|x| x.theaters >= min_theaters && !x.periods.nil?}
    return [] if wide_periods.empty? ||  wide_periods.nil?
    first_wide_period = wide_periods.min.periods
    self.results.collect{|x| x if x.periods >= first_wide_period}.compact[0..max_periods-1]
  end
  
  def self.import_all
    data_file = "#{Rails.root}/tmp/data/movies.txt"
    # Here I should parse from the web to the local file
    FasterCSV.foreach(data_file, :headers => :first_row) do |row|
      studio = Studio.find_or_create_by_code(:code => row["studio_code"], :name => row["studio_name"])
      genre = Genre.find_or_create_by_name(:name => row["genre_name"])
      rating = Rating.find_or_create_by_code(:code => row["rating"])
      movie = Movie.find_or_initialize_by_code(:code => row["code"])
      movie.title = row["title"]
      movie.studio = studio
      movie.genre = genre
      movie.rating = rating
      movie.released_on = row["released_on"]
      movie.minutes = row["minutes"]
      movie.budget = row["budget"]
      movie.save!
    end    
    # this is fine, just remember to NOT include domestic here and import it together with the other intl totals
        
  end
  
end
