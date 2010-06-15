class Machine < ActiveRecord::Base
   validates :title, :uniqueness => true
end
