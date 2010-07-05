namespace :bootstrap do
   mt = []
   mt << { :name => 'IKR', :ram_gib => 4, :cores => 4, :cpu_type => "AMD Opteron 275 2.2Ghz", :count => 30 }
   mt << { :name => 'Mozart', :ram_gib => 8, :cores => 4, :cpu_type => "Intel Xeon 3360 2.8Ghz", :count => 16 }
   mt << { :name => 'Dryad', :ram_gib => 16, :cores => 8, :cpu_type => "AMD Opteron 2376 2.3GHz", :count => 16 }


   desc "Add the default user"
   task :default_user => :environment do
      User.create( :name => 'nico2' )
   end

   desc "Create machine types with machines"
   task :machine_types => :environment do
      mt.each do |type|
         mtn = MachineType.create type
      end
   end

   desc "Run all bootstrapping tasks"
   task :all => [:default_user, :machine_types]
end

