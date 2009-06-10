class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :item, :polymorphic => true
  belongs_to :movie, :class_name => "Movie", :foreign_key => "item_id"
  belongs_to :genre, :class_name => "Genre", :foreign_key => "item_id"
  
  named_scope :included, :conditions => {:exclude => false}
  named_scope :excluded, :conditions => {:exclude => true}
  named_scope :by_movie, :conditions => {:item_type => 'Movie'}
  named_scope :by_genre, :conditions => {:item_type => 'Genre'}
  
  named_scope :by_movie2, :conditions => {:item_type => 'Movie'} do
    def movies(excluded = false)
      Movie.scoped(:include => [:genre, :studio, :rating], :conditions => 
        {:id => collect{|m| m.item_id if m.exclude == excluded}.compact}
      )
    end
  end
  named_scope :by_genre, :conditions => {:item_type => 'Genre'} do
    def movies(excluded = false)
      Movie.scoped(:include => [:genre, :studio, :rating], :conditions => 
        {:genre_id => collect{|m| m.item_id if m.exclude == excluded}.compact}
      )
    end
  end
  
  def self.movies
#    by_movie.movies + by_genre.movies - by_movie.movies(true) - by_genre.movies(true)
      Movie.scoped( # :include => [:genre, :studio, :rating], 
        :conditions => 
        ["(movies.id IN ?)", movies.collect{|m| m.item_id if m.type = 'Movie' and m.exclude == excluded}.compact]
      )
  
  end

end
