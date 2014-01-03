set :application, 'bank_checker'
set :repo_url, 'git@github.com:agustinf/bice_check.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Server-side information.
set :deploy_to,   "/home/deploy/applications/bank_checker"
# set :scm, :git
set :rbenv_ruby, File.read('.ruby-version').strip
# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :default_env, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.nodenv/shims:$HOME/.nodenv/bin:$PATH"
}

set :rbenv_ruby, '2.0.0-p247'
# set :keep_releases, 5

set :rbenv_map_bins, %w{rake gem bundle ruby rails whenever}

namespace :deploy do

  desc 'Sets the environmental variables'
  task :env_set do
    on roles(:app) do
      execute "ln -s /home/deploy/applications/bank_checker/shared/.rbenv-vars #{release_path}/.rbenv-vars" 
    end
  end

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do

    end
  end

  after 'deploy:symlink:shared', 'deploy:env_set'

  after :finishing, 'deploy:cleanup'

end
