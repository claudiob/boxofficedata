class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.references :movie
      t.references :country
#     t.references :period, :polymorphic => { :default => 'weekend' }
      t.integer :period_id
      t.string  :period_type, :limit => 8, :default => 'Weekend'
      t.integer :position
      t.integer :gross
      t.integer :cumulative
      t.integer :theaters
      t.integer :periods
    end
    add_index :results, :movie_id
    add_index :results, :country_id
    add_index :results, :period_type
    add_index :results, [:period_type, :period_id], :name => "period"
    add_index :results, [:movie_id, :period_type, :period_id], :unique => true
  end

  def self.down
    remove_index :results, :column => [:movie_id, :period_type, :period_id]
    remove_index :results, :name => :period
    remove_index :results, :period_type
    remove_index :results, :country_id
    remove_index :results, :movie_id
    drop_table :results
  end
end
