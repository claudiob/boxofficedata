class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :name
    end
    add_index :countries, :name, :unique => true
    Country.create!(:name => "United States")
  end

  def self.down
    remove_index :countries, :column => :name
    drop_table :countries
  end
end
