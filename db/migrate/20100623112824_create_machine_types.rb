class CreateMachineTypes < ActiveRecord::Migration
  def self.up
    create_table :machine_types do |t|
      t.string :name
      t.float :ram_gib
      t.integer :cores
      t.string :cpu_type

      t.timestamps
    end
  end

  def self.down
    drop_table :machine_types
  end
end
