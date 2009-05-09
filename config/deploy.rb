set :application, "pse"
set :repository,  "git://github.com/nebolsin/cmc-pse.git"
set :scm, :git
set :user, 'pse'

set :deploy_to, "/var/www/pse"

role :app, "pse.jnf.ru"
role :web, "pse.jnf.ru"
role :db,  "pse.jnf.ru", :primary => true

ssh_options[:paranoid] = false

namespace :deploy do

  desc "Deploys your project."
  task :default do
    update
    restart
  end

  desc "Flush data on all memcache servers"
  task :flush do
    run "cd #{deploy_to} && ./script/runner -e production Rails.cache.clear"
  end


  desc "Merge current master into production"
  task :merge do
    `git checkout production && git merge master && git pull && git push && git checkout master`
  end

  desc "Task that updates running code"
  task :update, :roles => :app do
    run "cd #{deploy_to} && git pull && git submodule update"
    # flush
    glue_code
  end

  desc "Glue assets"
  task :glue_code, :roles => :app do
    run "cd #{deploy_to} && mkdir -p public/stylesheets && rm -f public/stylesheets/application.css public/javascripts/application.js && curl -o public/stylesheets/app1.css http://new.prophotos.ru/stylesheets/application.css && mv public/stylesheets/app1.css public/stylesheets/application.css"
  end

  desc "Task that run current migrations"
  task :migrate, :roles => :db do
    run "cd #{deploy_to} ; PATH=$PATH:/opt/local/ruby/bin RAILS_ENV=production rake db:migrate"
  end


  task :before_migrate, :roles => :app do
    update
  end

  task :after_migrate, :roles => :app do
    restart
  end

  task :before_restart, :roles => :app do
    run "cd #{deploy_to}; rm -f public/stylesheets/cache/*.css public/javascripts/cache/*.js"
  end

  desc "Restart application"
  task :restart do
    run "cd #{deploy_to} ; mkdir -p tmp && touch tmp/restart.txt"
  end

  desc "The spinner task is used by :cold_deploy to start the application up"
  task :spinner, :roles => :app do
  end
end
