class Booking < ActiveRecord::Base
   belongs_to :user
   has_many :reservations

   accepts_nested_attributes_for :reservations

   validates :user_id, :presence => true
   validates_associated :user

   def user_name
      user_id ? User.find(user_id).name : ""
   end

   def user_name=(input)
      #searchresult=User.find_by_name(input)
      #self.user_id= searchresult ? searchresult : -1 
      self.user_id=User.find_by_name(input).id
   end

end
