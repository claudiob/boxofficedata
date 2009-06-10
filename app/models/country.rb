class Country < ActiveRecord::Base
  has_many :results
  
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  named_scope :worldwide, :conditions => {:name => "Worldwide"}

  def self.default
    self.find_by_name("United States")
  end

end
