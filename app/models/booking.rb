class Booking < ActiveRecord::Base
   belongs_to :user
   has_many :reservations

   accepts_nested_attributes_for :reservations

   validates :user_id, :presence => true
end
