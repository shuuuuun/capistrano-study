# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "study-app"
# set :repo_url, "git@github.com:shuuuuun/sinatra-starter.git"
set :repo_url, "git@github.com:shuuuuun/rails6-study.git"
set :user, "app"
set :group, "app"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, "/var/app/#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :default_env, { RAILS_MASTER_KEY: ENV.fetch("RAILS_MASTER_KEY") }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
set :ssh_options, {
  user: "app",
  port: 2222,
  keys: [ENV["APP_SSH_KEY"]],
  forward_agent: true,
  auth_methods: %w(publickey)
}

set :rbenv_type, :system
set :rbenv_ruby, '3.0.0'
# set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"

set :puma_user, fetch(:user)
set :puma_systemctl_user, :system # accepts :user
set :puma_role, :app
# set :puma_bind, "tcp://0.0.0.0:9292"
set :puma_service_unit_env_vars, %W[
  RBENV_ROOT=#{fetch(:rbenv_path)}
  RBENV_VERSION=#{fetch(:rbenv_ruby)}
  RAILS_MASTER_KEY=#{ENV.fetch("RAILS_MASTER_KEY")}
]

namespace :puma do
  desc 'Create Directories for Puma'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/tmp/sockets"
      execute "mkdir -p #{shared_path}/tmp/pids"
      execute "mkdir -p #{shared_path}/log"
      # execute "chown -R app:app #{shared_path}/"
    end
  end

  # before :start, :make_dirs
  # before :restart, :make_dirs
end

# namespace :deploy do
#   desc 'Start application'
#   task :start do
#     on roles(:app) do
#       # invoke 'unicorn:start'
#       within "#{deploy_to}/current" do
#         # execute "bundle exec ruby app.rb"
#         execute "bundle exec puma"
#       end
#     end
#   end

#   after :publishing, :start
# end
