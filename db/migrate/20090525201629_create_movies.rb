class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :title
      t.string :code
      t.references :studio
      t.references :genre
      t.references :rating
      t.integer :minutes
      t.date :released_on
      t.decimal :budget, :precision => 8, :scale => 2
    end
    add_index :movies, :code, :unique => true
    add_index :movies, :studio_id
    add_index :movies, :genre_id
    add_index :movies, :rating_id
  end

  def self.down
    remove_index :movies, :rating_id
    remove_index :movies, :genre_id
    remove_index :movies, :studio_id
    remove_index :movies, :column => :code
    drop_table :movies
  end
end
