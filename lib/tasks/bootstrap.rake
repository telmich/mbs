namespace :bootstrap do
   mt = []
   mt << { :name => 'IKR', :ram_gib => 4, :cores => 4, :cpu_type => "AMD Opteron 275 2.2Ghz" }
   mt << { :name => 'Mozart', :ram_gib => 8, :cores => 4, :cpu_type => "Intel Xeon 3360 2.8Ghz" }
   mt << { :name => 'Dryad', :ram_gib => 16, :cores => 8, :cpu_type => "AMD Opteron 2376 2.3GHz" }


   desc "Add the default user"
   task :default_user => :environment do
      User.create( :name => 'nico2' )
   end

   desc "Create machine types with machines"
   task :machine_types => :environment do
      mt.each do |type|
         mtn = MachineType.create type



         puts type.to_s

         i = 1
         while i <= 1 # type[:count]
            name = sprintf "%s%0.2d", type[:name].downcase, i
            puts name, "\n"
            #Machine.create { :name => name, :usable => true, :machine_type_id => mtn.id }
            i += 1
         end
      end
   end

   desc "Run all bootstrapping tasks"
   task :all => [:default_user, :machine_types]
end

