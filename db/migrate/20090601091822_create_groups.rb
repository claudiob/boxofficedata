class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.timestamps
    end
    add_index :groups, :name, :unique => true
  end

  def self.down
    remove_index :groups, :column => :name
    drop_table :groups
  end
end
