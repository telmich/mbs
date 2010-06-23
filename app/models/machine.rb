class Machine < ActiveRecord::Base
   validates :title, :uniqueness => true
   validates_presence_of :ram
   validates_presence_of :cores
   validates_presence_of :cpu_type

   has_many :reservations, :dependent => :destroy
end
