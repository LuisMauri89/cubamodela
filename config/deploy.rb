# config valid only for current version of Capistrano
lock "3.7.1"

set :application, "cubamodela"
set :repo_url, "git@github.com:LuisMauri89/cubamodela.git"
set :deploy_user, 'deployer'

set :use_sudo, false
set :bundle_binstubs, nil
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :keep_releases, 5
set :pty,  false

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:reload'
  end
end

# cap production deploy:invoke task=db:seed
namespace :deploy do
  desc "Invoke rake db:seed"
  task :db_seed do
    on roles(:app) do
      execute :cd, "#{deploy_to}/current"
      execute :rake, "db:seed"
    end
  end

  # rake db:reset drops the database, then loads the schema with rake db:schema:load and then seeds the data with rake db:seed
  desc "Invoke rake db:reset"
  task :db_reset do
    on roles(:app) do
      execute :cd, "#{deploy_to}/current"
      execute :rake, "db:reset"
    end
  end

  desc "Invoke Drop, Create, Migrate Seed"
  task :db_reseed do
    on roles(:app) do
      execute :cd, "#{deploy_to}/current"
      execute :rake, "db:drop"
      execute :rake, "db:create"
      execute :rake, "db:migrate"
      execute :rake, "db:seed"
    end
  end

  desc "Invoke rake memcached:flush"
  task :memcached_flush do
    on roles(:app) do
      execute :cd, "#{deploy_to}/current"
      execute :rake, "memcached:flush"
    end
  end
end

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
