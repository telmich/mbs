class Machine < ActiveRecord::Base
   validates :title, :uniqueness => true

   has_many :reservations, :dependent => :destroy
   belongs_to :machine_type
end
