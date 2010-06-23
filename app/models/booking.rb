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
      userexists=User.find_by_name(input)
      if userexists 
         self.user_id=searchresult.id
      end
   end

end
