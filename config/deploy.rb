# =============================================================================
# REQUIRED VARIABLES
# =============================================================================
# The name of your application.
set :application, "nshvll"

# Target directory for the application on the web and app servers.
set :deploy_to, "/var/www/apps/#{application}"

# Primary domain name of your application. Used as a default for all server roles.
set :domain, "nshvll.org"

# Login user for ssh.
set :user, "deploy"
set :use_sudo, false

# =============================================================================
# ROLES
# =============================================================================
# Modify these values to execute tasks on a different server.
role :web, domain
role :app, domain
role :db,  domain, :primary => true
role :scm, domain

# =============================================================================
# SCM OPTIONS
# =============================================================================
set :scm, :git
set :repository, "git@github.com:travisr/nshvll.git"
set :branch, :master

# =============================================================================
# CAPISTRANO OPTIONS
# =============================================================================
set :keep_releases, 3
set :deploy_via, :remote_cache

# action to symlink database file
namespace :deploy do
  desc "Symlink database and environment config files."
  task :symlink_files do
    run "ln -nfs #{shared_path}/system/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/email.rb #{release_path}/config/initializers/email.rb"
  end
end
 
after 'deploy:update_code', 'deploy:symlink_files'
after 'deploy:symlink', 'deploy:cleanup'
