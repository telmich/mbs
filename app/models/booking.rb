class Booking < ActiveRecord::Base
   has_many :reservations
   belongs_to :user

   accepts_nested_attributes_for :reservations

   validates :user_id, :presence => true
end
