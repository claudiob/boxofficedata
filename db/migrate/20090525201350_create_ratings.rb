class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.string :code, :limit => 32
    end
    add_index :ratings, :code, :unique => true
  end

  def self.down
    remove_index :ratings, :column => :code
    drop_table :ratings
  end
end
