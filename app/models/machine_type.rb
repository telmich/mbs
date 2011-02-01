class MachineType < ActiveRecord::Base
   validates :name, :uniqueness => true

   validates_presence_of :ram_gib
   validates_presence_of :cores
   validates_presence_of :cpu_type
   validates_numericality_of :count, :greater_than_or_equal_to => 0, :only_integer => true

   has_many :machines, :dependent => :destroy

   accepts_nested_attributes_for :machines

   before_save :create_machines

   attr_accessor :machine_description

   @machines = []
   @machine_description = ""

   def count
      self.machines.count
   end
      
   def count=(input)
      @count=input
   end

   # autocreate, mostly used during seeding
   def create_machines
      i = 1
      self.machines = []
      status = MachineStatus.find_by_name("bookable")

      while i <= @count.to_i
         name = sprintf "%s%0.2d", self.name.downcase, i
         self.machines << Machine.new({ :name => name,
                                       :description => @machine_description,
                                       :machine_status => status
                                    })
         i += 1
      end 
   end

   # all those which COULD be bookable from status point of view
   def bookable
      count = 0
      machines.each do |m|
         if m.machine_status == MachineStatus.find_by_name("bookable")
            count += 1
         end
      end
      count
   end
      
   def free_machines
      count = 0
      dates = Booking.now

      machines.each do |machine|
         if machine.is_free?(dates)
            count += 1
         end
      end

      count
   end
end
