class CreateTeil2s < ActiveRecord::Migration
  def self.up
    create_table :teil2s do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :teil2s
  end
end
