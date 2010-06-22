class RemoveDateFromReservation < ActiveRecord::Migration
  def self.up
    remove_column :reservations, :begin
    remove_column :reservations, :end
  end

  def self.down
    add_column :reservations, :end, :datetime
    add_column :reservations, :begin, :datetime
  end
end
