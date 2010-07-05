class MachineType < ActiveRecord::Base
   validates :name, :uniqueness => true

   validates_presence_of :ram_gib
   validates_presence_of :cores
   validates_presence_of :cpu_type
   validates_numericality_of :count, :greater_than_or_equal_to => 0, :only_integer => true

   has_many :machines, :dependent => :destroy

   accepts_nested_attributes_for :machines

   def description
      puts "Retr desc of " + @description.to_s + "\n"
      @description
   end
      
   def description=(input)
      @description=input
      puts "Set desc to " + @description + "\n"
   end
      
   def count
      self.machines.count
   end
      
   def count=(input)
      i = 1 
      machines = []

      while i <= input.to_i
         name = sprintf "%s%0.2d", self.name.downcase, i
         puts "Creating in model " + name + " with desc=." + description.to_s + ".\n"
         machines << { :name => name, :description => self.description, :usable => true } 
         i += 1
      end 
      self.machines_attributes = machines
   end
      
end
