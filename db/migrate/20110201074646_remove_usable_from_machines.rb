class RemoveUsableFromMachines < ActiveRecord::Migration
  def self.up
    remove_column :machines, :usable
  end

  def self.down
    add_column :machines, :usable, :boolean
  end
end
