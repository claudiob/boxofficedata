class Genre < ActiveRecord::Base
  has_many :movies
  has_many :memberships, :as => :item
  has_many :groups, :through => :memberships

  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"

end
