class Weekend < ActiveRecord::Base
  has_many :results, :as => :period
  validates_presence_of :year, :on => :create, :message => "can't be blank"
  validates_presence_of :week, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :week, :scope => :year, :on => :create, :message => "must be unique"
  validates_inclusion_of :year, :in => 1900..2100, :on => :create, :message => "invalid year"
  validate :valid_week?, :on => :create

  def <=>(other)  
    year_cmp = year <=> other.year
    if year_cmp != 0
      return year_cmp
    else
      return week <=> other.week
    end
  end  
  
  def ends_on
    #"#{week}/#{year}"
    (Date.civil(year,1,1).first_friday + (week-1).weeks).to_s(:short) 
  end
  
  def import_results
    import_results_from_local_file
  end
  
  def import_results_from_local_file
    data_dir = "#{Rails.root}/tmp/data/weekend_results"
    data_file = "#{data_dir}/yr#{self.year}_wknd#{self.week}.txt"
    FasterCSV.foreach(data_file, :headers => :first_row) do |row|
      studio = Studio.find_or_create_by_code(row["studio_code"], :name => row["studio_name"])
      movie = Movie.find_or_create_by_code(row["code"], :title => row["title"], :budget => row["budget"], :studio => studio)
      result = self.results.find_or_initialize_by_movie_id(movie.id)
      result.position = row["position"]
      result.gross = row["gross"]
      result.cumulative = row["cumulative"]
      result.theaters = row["theaters"]
      result.periods = row["weeks"]
      result.save!
    end    
  end
      
  private
  
  def valid_week?
    if year and not year.weeks_in_year.include?(week) 
      errors.add(:week, "is invalid")
    end
  end
  
end
