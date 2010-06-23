class AddFieldsToMachine < ActiveRecord::Migration
  def self.up
    add_column :machines, :ram, :integer
    add_column :machines, :cores, :integer
    add_column :machines, :cpu_type, :string
  end

  def self.down
    remove_column :machines, :cpu_type
    remove_column :machines, :cores
    remove_column :machines, :ram
  end
end
