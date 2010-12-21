#!/usr/bin/env bash
# See http://mywiki.wooledge.org/BashGuide/Practices#Choose_Your_Shell
# Needs bash to load ~/.bash_profile

echo $SHELL
echo $0

set -e

export ddir=$HOME/rails

# Setup pre-ruby: RVM
export http_proxy=http://proxy.ethz.ch:3128
~/rvminstall
# load rvm

# WARNING: BASH SPECIFIC CODE
. ~/.bash_profile 

# Setup ruby
rvm install ruby-1.8.7
rvm gemset create rails
rvm use ruby-1.8.7@rails
gem install bundler

# Setup application
git clone git://git.sans.ethz.ch/mbs
rsync -av mbs/ ~/rails/

cd ~/rails/
bundle install

# Setup Database
rake db:setup
rake db:migrate
rake db:seed

#rake bootstrap:machine_types

