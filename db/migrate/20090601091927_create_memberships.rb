class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.references :group
      t.references :item, :polymorphic => { :default => 'movie' }
      t.boolean :exclude, :default => false
      t.timestamps
    end
    add_index :memberships, [:item_type, :item_id], :name => "item"
    add_index :memberships, [:item_type, :item_id, :group_id], :unique => true
  end

  def self.down
    remove_index :memberships, :column => [:item_type, :item_id, :group_id]
    remove_index :memberships, :name => :item
    drop_table :memberships
  end
end
