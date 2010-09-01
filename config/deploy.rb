set :application, "mbs"
set :repository,  "git://git.sans.ethz.ch/mbs"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "sgv-rails-01"                          # Your HTTP server, Apache/etc
role :app, "sgv-rails-01"                          # This may be the same as your `Web` server
role :db,  "sgv-rails-01", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

set :deploy_to, "/tmp/zubaden"
set :user, "root"
set :use_sudo, false
