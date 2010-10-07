class Booking < ActiveRecord::Base
   belongs_to :user
   has_many :reservations, :dependent => :destroy

   attr_writer :nodes_count

   accepts_nested_attributes_for :reservations

   # validations are run in order of appereance!
   validates_presence_of :user_id, :presence => true, :message => "Foo"
#   validates_associated  :user

   validates_presence_of :begin
   validates_presence_of :end
   validates_presence_of :nodes_count, :presence => true

   validate :begin_lt_end, :machines_available

   @nodes_count = {}

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

   # depends on nodes_count=
   def machines_available
      @machines_to_book = []

      @nodes_count.each_pair do |type, count|
         typename = MachineType.find(type).name

        puts "Searching " + count.to_s + " " + typename + " machines"

         count = count.to_i
         all_machines = MachineType.find(type).machines

         if count > all_machines.count
            self.errors[:base] << "Trying to book more " + typename + "s than existing."
         else

            reservable_machines_count = 0 
            all_machines.each do |machine|
               break if count == reservable_machines_count

               if machine.is_free?({:begin => self.begin, :end => self.end})
                  puts "Adding machine " + machine.name + "for " + MachineType.find(type).name
                  reservable_machines_count += 1
                  @machines_to_book << { :machine_id => machine.id }
               end 

         end

         if count != reservable_machines_count
            self.errors[:base] << "Only " + reservable_machines_count.to_s + " " + MachineType.find(type).name + "(s) available at the choosen date."

            # be nice to the user and set the count to what is available
            @nodes_count[type] = reservable_machines_count
         end 

         end
      end

      if @machines_to_book.empty?
         self.errors[:base] << "Zero machines selected"
      else
         self.reservations_attributes = @machines_to_book
      end
   end

   # return "current" booking time: now + 1 day
   def Booking.now
      dt = DateTime.now

      { :begin => dt, :end => dt + 1.day }
   end

end
