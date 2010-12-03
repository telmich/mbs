class AddMachineStatusToMachine < ActiveRecord::Migration
  def self.up
    add_column :machines, :machine_status_id, :integer
  end

  def self.down
    remove_column :machines, :machine_status_id
  end
end
