class CreateStudios < ActiveRecord::Migration
  def self.up
    create_table :studios do |t|
      t.string :code, :limit => 64
      t.string :name, :limit => 32
    end
  end

  def self.down
    drop_table :studios
  end
end
