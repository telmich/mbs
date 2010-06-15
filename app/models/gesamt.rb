class Gesamt < ActiveRecord::Base
   has_many :teil1s
   has_many :teil2s
end
