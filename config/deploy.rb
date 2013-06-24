set :application, "Shiv"
set :repository,  "git@gitlab.sdsc.edu:shiv.git"
set :user, "jenkins"
set :use_sudo, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "shiv.sdsc.edu"                          # Your HTTP server, Apache/etc
role :app, "shiv.sdsc.edu"                          # This may be the same as your `Web` server
role :db,  "shiv.sdsc.edu", :primary => true        # This is where Rails migrations will run

set :deploy_to, "/opt/#{application.downcase}/server"

# symlink the database.yml file after updating the code
after 'deploy:update_code', 'deploy:symlink_db'

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

namespace :deploy do

  ## Override the start, stop, and restart tasks since we're using Passenger
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  # symlink the shared/config/database.yml so we don't have to store the db
  # config in the repository
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end
