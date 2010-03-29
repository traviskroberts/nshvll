require 'railsmachine/recipes'

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
set :runner, user
set :admin_runner, user

# Rails environment. Used by application setup tasks and migrate tasks.
set :rails_env, "production"

# =============================================================================
# ROLES
# =============================================================================
# Modify these values to execute tasks on a different server.
role :web, domain
role :app, domain
role :db,  domain, :primary => true
role :scm, domain

# =============================================================================
# APPLICATION SERVER OPTIONS
# ============================================================================= 
set :app_server, :passenger  # :mongrel or :passenger

# =============================================================================
# DATABASE OPTIONS
# =============================================================================
set :database, "mysql"   # mysql or postgresql

# =============================================================================
# SCM OPTIONS
# =============================================================================
set :scm, :git    # :subversion or :git
set :repository, "git@github.com:travisr/nshvll.git"

# =============================================================================
# CAPISTRANO OPTIONS
# =============================================================================
# default_run_options[:pty] = true
set :keep_releases, 3
set :deploy_via, :remote_cache

# action to symlink database file
namespace :deploy do
  desc "Symlink database and environment config files."
  task :symlink_files do
    run "ln -nfs #{shared_path}/system/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/system/environment.rb #{release_path}/config/environment.rb"
  end
end
 
after 'deploy:update_code', 'deploy:symlink_files'
