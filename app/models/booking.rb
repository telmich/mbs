class Booking < ActiveRecord::Base
   # WARNING: validations are run in order of appereance!
   
   belongs_to :user
   belongs_to :modifier, :class_name => "User", :foreign_key => "modified_by"
   has_many :reservations, :dependent => :destroy

   # User verification, must always be present!
   # user vs user_id:
   # http://stackoverflow.com/questions/3755828/ruby-on-rails-question-about-validates-presence-of
   validates_presence_of :user, :presence => true, :message => "User missing"
   validates_associated  :user

   # allow submit of nodes_count hash from the view
   attr_writer :nodes_count

   # allow direct creation of reservations
   accepts_nested_attributes_for :reservations

   validates_presence_of :begin
   validates_presence_of :end

   validate :begin_lt_end
   validate :has_one_or_more_reservations

   before_validation :create_reservations

   def has_one_or_more_reservations
      puts "has_one_or_more_reservations: " + reservations.to_s
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

   def create_reservations
     # Mark booking existing (vs. deleted)
      machines = Machine.all
      machine_types = MachineType.all

      # Locate machines, depends on nodes_count=
      machines_to_book = []

      # Search for nodes if a count is submitted (vs. node ids submitted)
      if nodes_count
         nodes_count.each_pair do |type, count|
            typename = MachineType.find(type).name

            count = count.to_i
            all_machines = MachineType.find(type).machines

            if count > all_machines.count
               errors[:base] << "Trying to book more " + typename + "s than existing."
            else
               reservable_machines_count = 0 
               all_machines.each do |machine|
                  break if count == reservable_machines_count

                  if machine.is_free?({:begin => self.begin, :end => self.end})
                     reservable_machines_count += 1
                     machines_to_book << machine
                  end 
               end 

               if count != reservable_machines_count
                  errors[:base] <<"Only " + reservable_machines_count.to_s + " " + MachineType.find(type).name + "(s) available at the choosen date."

                  # be nice to the user and set the count to what is available
                  nodes_count[type] = reservable_machines_count
               end 
            end 
         end 

         # Setup REAL reservations independent of previous errors
         # (they cause abort anyway and we do not trigger the "no machines booked"
         # message
         self.reservations = []
         machines_to_book.each do |m|
            self.reservations << Reservation.new(:machine_id => m.id)
         end
      end
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
