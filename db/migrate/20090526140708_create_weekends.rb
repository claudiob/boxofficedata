class CreateWeekends < ActiveRecord::Migration
  def self.up
    create_table :weekends do |t|
      t.integer :week
      t.integer :day

      t.timestamps
    end
  end

  def self.down
    drop_table :weekends
  end
end
