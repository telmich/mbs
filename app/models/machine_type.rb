class MachineType < ActiveRecord::Base
   validates :name, :uniqueness => true

   validates_presence_of :ram_gib
   validates_presence_of :cores
   validates_presence_of :cpu_type
   validates_numericality_of :count, :greater_than_or_equal_to => 0, :only_integer => true

   has_many :machines, :dependent => :destroy

   accepts_nested_attributes_for :machines

   # FIXME: add machine creation support into the model,
   # so it's not dependent on the controller

   def count
      self.machines.count
   end
      
   def count=(input)
      i = 1 
      machines = []
      #while i <= params[:machine_type][:count].to_i
      while i <= input.to_i
         name = sprintf "%s%0.2d", self.name.downcase, i
         puts "Creating in model " + name, "\n"
         machines << { :name => name, :description => "automachine", :usable => true } 
         i += 1
      end 
      self.machines_attributes = machines
   end
      
end
