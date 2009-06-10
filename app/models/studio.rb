class Studio < ActiveRecord::Base
  has_many :movies
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_presence_of :code, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :code, :on => :create, :message => "must be unique"
  validates_length_of :name, :within => 1..32, :on => :create, :message => "too long"
  validates_length_of :code, :within => 1..64, :on => :create, :message => "too long"
end
