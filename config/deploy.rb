# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'Employee-Management'
set :repo_url, 'git@github.com:navin-gr/employee_management.git' #path of application git repository
set :rvm_roles, [:app, :web]
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp


set :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/rails_apps/my_app_name' # where to put your application code

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

set :linked_files, %w{config/database.yml}
set :rvm_ruby_version, 'ruby-2.2.2@latest-version'

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


  task :db_create do
    run "cd #{current_path};RAILS_ENV=#{rails_env} bundle exec rake db:create"
  end

  after "deploy", "db_create"
  after "deploy", "deploy:migrate"

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
