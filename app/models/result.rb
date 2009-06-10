require 'fastercsv'
class Result < ActiveRecord::Base
  belongs_to :measurable, :polymorphic => true
  belongs_to :country
  belongs_to :period, :polymorphic => true
  
  validates_presence_of :measurable, :message => "can't be blank"
  validates_presence_of :period, :message => "can't be blank"
  validates_presence_of :country, :message => "can't be blank"

  def <=>(other)
    periods <=> other.periods
  end
  
  def before_validation_on_create
    self.country = Country.default if self.country.nil?
  end
  
  def self.import_all_weekends(years = 1980..2009)
    years.each do |year|
      year.weeks_in_year.each do |week|
        weekend = Weekend.find_or_create_by_year_and_week(year, week)
        logger.debug "Importing results for weekend #{week}/#{year}"
        weekend.import_results
      end
    end
  end
    
end
