class CreateEndusers < ActiveRecord::Migration
  def self.up
    create_table :endusers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :endusers
  end
end
