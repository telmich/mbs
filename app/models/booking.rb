class Booking < ActiveRecord::Base
   belongs_to :user
   has_many :reservations

   accepts_nested_attributes_for :reservations

   validates :user_id, :presence => true
   validates_associated :user

   validate :begin_lt_end

   def user_name
      user_id ? User.find(user_id).name : ""
   end

   def user_name=(input)
      userexists=User.find_by_name(input)
      if userexists 
         self.user_id=userexists.id
      end
   end

   def nodes_count
      puts "Retrieving nodes for "
      0
   end

   def nodes_count=(input)
     @nodes_count=input 
     puts "Nodes: " + @nodes_count.to_s
   end

   def begin_lt_end
      errors[:base] << "End should be after begin." if (self.begin >= self.end)
   end

end
