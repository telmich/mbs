class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.datetime :begin
      t.datetime :end
      t.integer :machine_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :reservations
  end
end
