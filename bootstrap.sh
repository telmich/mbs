ddir=~/rails

git clone git://git.sans.ethz.ch/mbs $ddir

cd $ddir

# does not add entries from seed!
rake db:setup
rake db:migrate
rake bootstrap:machine_types

