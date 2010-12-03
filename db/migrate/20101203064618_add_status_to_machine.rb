class AddStatusToMachine < ActiveRecord::Migration
  def self.up
    add_column :machines, :status, :integer
  end

  def self.down
    remove_column :machines, :status
  end
end
