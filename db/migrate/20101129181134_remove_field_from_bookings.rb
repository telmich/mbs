class RemoveFieldFromBookings < ActiveRecord::Migration
  def self.up
    remove_column :bookings, :valid
  end

  def self.down
    add_column :bookings, :valid, :boolean
  end
end
