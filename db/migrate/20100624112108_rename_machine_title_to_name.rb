class RenameMachineTitleToName < ActiveRecord::Migration
  def self.up
   rename_column :machines, :title, :name 
  end

  def self.down
   rename_column :machines, :name, :title 
  end
end
