class MachineType < ActiveRecord::Base
   validates :name, :uniqueness => true

   validates_presence_of :ram_gib
   validates_presence_of :cores
   validates_presence_of :cpu_type
   validates_presence_of :count

   has_many :machines, :dependent => :destroy

   accepts_nested_attributes_for :machines

   def count
      self.machines.count
   end
      
   def count=(input)
      @count = input
   end
      
end
