class MakeResultsPolymorphic < ActiveRecord::Migration
  def self.up
    remove_index :results, :column => [:movie_id, :period_type, :period_id]
    remove_index :results, :movie_id
    rename_column :results, :movie_id, :measurable_id
    add_column :results, :measurable_type, :string, :limit => 8, :default => 'Movie'
    add_index :results, :measurable_type
    add_index :results, [:measurable_type, :measurable_id], :name => "measurable"
    add_index :results, [:measurable_type, :measurable_id, :period_type, :period_id], :name => "unique", :unique => true
  end

  def self.down
    rename_column :table_name, :new_column_name, :column_name
    remove_index :results, :name => :unique
    remove_index :results, :name => :measurable
    remove_index :results, :measurable_type
    remove_column :results, :measurable_type
    rename_column :results, :measurable_id
    add_index :results, :movie_id
    add_index :results, [:movie_id, :period_type, :period_id], :unique => true
  end
end


