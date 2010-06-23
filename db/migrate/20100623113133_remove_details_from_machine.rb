class RemoveDetailsFromMachine < ActiveRecord::Migration
  def self.up
    remove_column :machines, :ram
    remove_column :machines, :cores
    remove_column :machines, :cpu_type
  end

  def self.down
    add_column :machines, :cpu_type, :string
    add_column :machines, :cores, :integer
    add_column :machines, :ram, :integer
  end
end
