require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

set :deploy_to, "{{ deploy_to }}"

set :domain, 'example.com'
set :repository, '{{ repo }}'
set :branch, '{{ branch }}'

set :user, '{{ user }}'

set :shared_paths, ['log', 'config/puma.rb', 'config/database.yml', 'tmp/pids', 'private']

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'

    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      invoke :'deploy:cleanup'
    end
  end
end
