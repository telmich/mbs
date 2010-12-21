class AddCommentToBookings < ActiveRecord::Migration
  def self.up
    add_column :bookings, :comment, :string
  end

  def self.down
    remove_column :bookings, :comment
  end
end
