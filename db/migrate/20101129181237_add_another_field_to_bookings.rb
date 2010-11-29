class AddAnotherFieldToBookings < ActiveRecord::Migration
  def self.up
    add_column :bookings, :existing, :boolean
  end

  def self.down
    remove_column :bookings, :existing
  end
end
