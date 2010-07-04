class MachineType < ActiveRecord::Base
   validates :name, :uniqueness => true

   validates_presence_of :ram_gib
   validates_presence_of :cores
   validates_presence_of :cpu_type

   has_many :machines,  :dependent => :destroy

   def count
      self.machines.count
   end
      
end
