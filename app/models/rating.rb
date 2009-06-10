class Rating < ActiveRecord::Base
  has_many :movies
  validates_presence_of :code, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :code, :on => :create, :message => "must be unique"
  validates_length_of :code, :within => 1..32, :on => :create, :message => "too long"
end
