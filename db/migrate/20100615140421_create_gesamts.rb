class CreateGesamts < ActiveRecord::Migration
  def self.up
    create_table :gesamts do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :gesamts
  end
end
