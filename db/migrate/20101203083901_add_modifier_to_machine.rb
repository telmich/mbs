class AddModifierToMachine < ActiveRecord::Migration
  def self.up
    add_column :machines, :modified_by, :integer
  end

  def self.down
    remove_column :machines, :modified_by
  end
end
