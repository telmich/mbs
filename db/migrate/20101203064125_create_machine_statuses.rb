class CreateMachineStatuses < ActiveRecord::Migration
  def self.up
    create_table :machine_statuses do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :machine_statuses
  end
end
