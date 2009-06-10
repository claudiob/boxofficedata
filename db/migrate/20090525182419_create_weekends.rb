class CreateWeekends < ActiveRecord::Migration
  def self.up
    create_table :weekends do |t|
      t.integer :year 
      t.integer :week
    end
  end

  def self.down
    drop_table :weekends
  end
end
