class Booking < ActiveRecord::Base
   has_many :reservations
   belongs_to :user

   validates :user_id, :presence => true
end
