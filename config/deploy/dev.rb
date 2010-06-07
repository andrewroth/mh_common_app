#require "#{File.dirname(__FILE__)}/../lib/cap_helper.rb"

set :moonshine_apply, false
set :application, "common"
set :repository,  "git://github.com/andrewroth/mh_common_app.git"
set :scm, "git"
set :keep_releases, 3
set :rails_env, "development"
set :branch, "c4c.dev"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "pat.powertochange.org"
role :web, "pat.powertochange.org"
role :db,  "pat.powertochange.org", :primary => true

set :user, 'deploy'
set :deploy_to, "/var/www/common.campusforchrist.org"

deploy.task :restart do
  # noop
end

def link_shared(p, o = {})
  if o[:overwrite]
    run "rm -Rf #{release_path}/#{p}"
  end

  run "ln -s #{shared_path}/#{p} #{release_path}/#{p}"
end

deploy.task :after_symlink do
  link_shared 'config/database.yml'
  link_shared 'config/database_root.yml'
  link_shared 'config/dbpw'
  run "cd #{release_path} && git submodule init"
  run "cd #{release_path} && git submodule update"
end
