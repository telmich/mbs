class CreateMachines < ActiveRecord::Migration
  def self.up
    create_table :machines do |t|
      t.string :title
      t.text :description
      t.boolean :usable

      t.timestamps
    end
  end

  def self.down
    drop_table :machines
  end
end
