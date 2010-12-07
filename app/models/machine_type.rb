class MachineType < ActiveRecord::Base
   validates :name, :uniqueness => true

   validates_presence_of :ram_gib
   validates_presence_of :cores
   validates_presence_of :cpu_type
   validates_numericality_of :count, :greater_than_or_equal_to => 0, :only_integer => true

   has_many :machines, :dependent => :destroy

   accepts_nested_attributes_for :machines

   before_save :create_machines

   attr_accessor :description

   @machines = []
   @description = ""

   def count
      self.machines.count
   end
      
   def count=(input)
      @count=input
   end

   def create_machines
      i = 1
      machines = []

      while i <= @count.to_i
         name = sprintf "%s%0.2d", self.name.downcase, i
         machines << { :name => name, :description => @description, :usable => true } 
         i += 1
      end 
      self.machines_attributes = machines
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
