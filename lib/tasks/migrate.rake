 namespace :migrate do
#    mt = []
#    mt << { :name => 'IKQ', :ram_gib => 2, :cores => 2, :cpu_type => "AMD Opteron 250 2.4Ghz", :count => 7, :description => "" }
#    mt << { :name => 'IKR', :ram_gib => 4, :cores => 4, :cpu_type => "AMD Opteron 275 2.2Ghz", :count => 30, :description => "" }
#    mt << { :name => 'Incredibles', :ram_gib => 8, :cores => 2, :cpu_type => "AMD Opteron 248 2.2Ghz", :count => 3, :description => "80/74 GB HD" }
#    mt << { :name => 'Mozart', :ram_gib => 8, :cores => 4, :cpu_type => "Intel Xeon 3360 2.8Ghz", :count => 16, :description => "" }
#    mt << { :name => 'Shrek', :ram_gib => 6, :cores => 4, :cpu_type => "Opteron 280 (2.4Ghz)/248 (2.2Ghz)", :count => 12, :description => "80 + (300|400) GB" }
#    mt << { :name => 'Dryad', :ram_gib => 16, :cores => 8, :cpu_type => "AMD Opteron 2376 2.3GHz", :count => 16, :description => "With two HDs" }
#    mt << { :name => 'Bach', :ram_gib => 24, :cores => 8, :cpu_type => "Intel Xeon L5520 2.26Ghz", :count => 30, :description => "Nehalem EP" }
#    mt << { :name => 'sgs-r815-', :ram_gib => 128, :cores => 48, :cpu_type => "AMD Opteron 6174 2.2GHz", :count => 1, :description => "Magny Cours" }
# 
# 

   desc "Transfer free machines"
   task :free_machines => :environment do
      Machine.find(:all, :conditions=> ["name like ?", "bach%"]).each do |m|
         m.machine_status =  MachineStatus.find_by_name("bookable")
         m.save
      end

      Machine.find(:all, :conditions=> ["name like ?", "dryad%"]).each do |m|
         m.machine_status =  MachineStatus.find_by_name("bookable")
         m.save
      end

      m = Machine.find_by_name("sgs-r815-01")
      m.machine_status =  MachineStatus.find_by_name("bookable")
      m.save

   end

   desc "Transfer General purpose machines"
   task :general_purpose => :environment do

      Machine.find(:all, :conditions=> ["name like ?", "ikq%"]).each do |m|
         m.machine_status =  MachineStatus.find_by_name ("general purpose")
         m.save
      end

      Machine.find(:all, :conditions=> ["name like ?", "incredibles%"]).each do |m|
         m.machine_status =  MachineStatus.find_by_name ("general purpose")
         m.save
      end

      Machine.find(:all, :conditions=> ["name like ?", "shrek%"]).each do |m|
         m.machine_status =  MachineStatus.find_by_name ("general purpose")
         m.save
      end

   end

   desc "Run all migration tasks"
   task :all => [:general_purpose, :free_machines]

end
