class AddMachineTypteToMachine < ActiveRecord::Migration
  def self.up
    add_column :machines, :machine_type, :integer
  end

  def self.down
    remove_column :machines, :machine_type
  end
end
