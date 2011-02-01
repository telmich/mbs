# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#User.create( :name => 'nico' )

# create host types
ms = [ "maintenance", "bookable", "general purpose" ]
ms.each do |name|
   mss = MachineStatus.create ({ :name => name })
   puts "Created status " + mss.name + "\n"
end 

mbookable = MachineStatus.find_by_name "bookable"

mt = []
mt << { :name => 'IKQ', :ram_gib => 2, :cores => 2, :cpu_type => "AMD Opteron 250 2.4Ghz", :count => 7, :machine_description => "" } 
mt << { :name => 'IKR', :ram_gib => 4, :cores => 4, :cpu_type => "AMD Opteron 275 2.2Ghz", :count => 30, :machine_description => "" } 
mt << { :name => 'Incredibles', :ram_gib => 8, :cores => 2, :cpu_type => "AMD Opteron 248 2.2Ghz", :count => 2, :machine_description => "80/74 GB HD" }
mt << { :name => 'Mozart', :ram_gib => 8, :cores => 4, :cpu_type => "Intel Xeon 3360 2.8Ghz", :count => 16, :machine_description => "" } 
mt << { :name => 'Shrek', :ram_gib => 6, :cores => 4, :cpu_type => "Opteron 280 (2.4Ghz)/248 (2.2Ghz)", :count => 12, :machine_description => "80 + (300|400) GB" }
mt << { :name => 'Dryad', :ram_gib => 16, :cores => 8, :cpu_type => "AMD Opteron 2376 2.3GHz", :count => 16, :machine_description => "With two HDs" }
mt << { :name => 'Bach', :ram_gib => 24, :cores => 8, :cpu_type => "Intel Xeon L5520 2.26Ghz", :count => 30, :machine_description => "Nehalem EP" }
mt << { :name => 'sgs-r815-', :ram_gib => 128, :cores => 48, :cpu_type => "AMD Opteron 6174 2.2GHz", :count => 1, :machine_description => "Magny Cours" }


mt.each do |type|
   mtn = MachineType.create type
   puts "Created machine type " + mtn.name + "\n"
end 

Machine.all do |m|
   m.machine_type = mbookable
end

# mark all as bookable - don't, do that in the migration!
# Machine.all.each do |m|
#    m.machine_status =  MachineStatus.find_by_name "bookable"
#    m.save
# end


