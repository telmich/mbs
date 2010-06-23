class RemoveTypteFromMachine < ActiveRecord::Migration
  def self.up
    remove_column :machines, :type
  end

  def self.down
    add_column :machines, :type, :integer
  end
end
