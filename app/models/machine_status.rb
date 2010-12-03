class MachineStatus < ActiveRecord::Base
   validates :name, :uniqueness => true, :presence => true
   has_many :machines
end
