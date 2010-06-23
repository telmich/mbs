class AddTypteToMachine < ActiveRecord::Migration
  def self.up
    add_column :machines, :type, :integer
  end

  def self.down
    remove_column :machines, :type
  end
end
