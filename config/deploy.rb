set :application, "Shiv"
set :repository,  "git@gitlab.sdsc.edu:shiv.git"
set :user, "jenkins"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "shiv.sdsc.edu"                          # Your HTTP server, Apache/etc
role :app, "shiv.sdsc.edu"                          # This may be the same as your `Web` server
role :db,  "shiv.sdsc.edu", :primary => true        # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
