class AddDatesToBookings < ActiveRecord::Migration
  def self.up
    add_column :bookings, :begin, :datetime
    add_column :bookings, :end, :datetime
  end

  def self.down
    remove_column :bookings, :end
    remove_column :bookings, :begin
  end
end
