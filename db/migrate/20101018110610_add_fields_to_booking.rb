class AddFieldsToBooking < ActiveRecord::Migration
  def self.up
    add_column :bookings, :modified_by, :integer
  end

  def self.down
    remove_column :bookings, :modified_by
  end
end
