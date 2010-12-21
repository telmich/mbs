class Booking < ActiveRecord::Base
   belongs_to :user
   belongs_to :modifier, :class_name => "User", :foreign_key => "modified_by"
   has_many :reservations, :dependent => :destroy

   # FIXME: why did I not use this?
   # validates_associated  :user


   # allow submit of nodes_count hash from the view
   attr_writer :nodes_count

   # allow direct creation of reservations
   accepts_nested_attributes_for :reservations

   # validations are run in order of appereance!
   validates_presence_of :user_id, :presence => true, :message => "User missing"

   validates_presence_of :begin
   validates_presence_of :end

   validate :begin_lt_end
   validate :has_one_or_more_reservations

   def has_one_or_more_reservations
      errors[:base] << "No machine selected" if (reservations.nil? or reservations.empty?)
   end

   def nodes_count(id=nil)
      # requested a specific nodes count?
      if id
         if @nodes_count.nil?
            0
         else
            @nodes_count[id.to_s]
         end
      else
         @nodes_count
      end
   end

   # depends on user_name=
   def user_name
      user_id ? User.find(user_id).name : ""
   end

   def user_name=(input)
      userexists=User.find_by_name(input)
      if userexists 
         self.user_id=userexists.id
      end
   end

   # depends on begin= and end=
   def begin_lt_end
      errors[:base] << "End should be after begin." if (self.begin >= self.end)
   end

   # return "current" booking time: now + 1 day
   def Booking.now
      dt = DateTime.now

      { :begin => dt, :end => dt + 1.day }
   end

   # Deleted bookings
   def Booking.deleted
      Booking.where :existing => false
   end

   scope :current,
      where("existing = :active AND begin <= :dt AND end >= :dt", {
         :dt => DateTime.now,
         :active => true
         })

   scope :expired,
      where("existing = :active AND end < :dt", {
         :dt => DateTime.now,
         :active => true
         })

   scope :future,
      where("existing = :active AND begin > :dt", {
         :dt => DateTime.now,
         :active => true
         })
end
