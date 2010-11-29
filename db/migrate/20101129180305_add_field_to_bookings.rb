class AddFieldToBookings < ActiveRecord::Migration
  def self.up
    add_column :bookings, :valid, :boolean
  end

  def self.down
    remove_column :bookings, :valid
  end
end
