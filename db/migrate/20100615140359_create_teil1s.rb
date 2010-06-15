class CreateTeil1s < ActiveRecord::Migration
  def self.up
    create_table :teil1s do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :teil1s
  end
end
