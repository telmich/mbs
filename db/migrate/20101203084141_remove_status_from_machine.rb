class RemoveStatusFromMachine < ActiveRecord::Migration
  def self.up
    remove_column :machines, :status
  end

  def self.down
    add_column :machines, :status, :integer
  end
end
