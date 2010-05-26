#require "#{File.dirname(__FILE__)}/../lib/cap_helper.rb"

set :moonshine_apply, false
set :application, "c4c_utility"
set :repository,  "git://github.com/andrewroth/c4c_utility.git"
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
set :deploy_to, "/var/www/c4c_utility.campusforchrist.org"

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
end

namespace :deploy do
  namespace :p2c do
    # NOTE making a loop to define these doesn't work in capistrano
    namespace :klone do
      desc "runs p2c:clone:emu remotely"
      task :emu do
        run_remote_rake "p2c:clone:emu"
      end
      desc "runs p2c:clone:intranet_dev remotely"
      task :ciministry do
        run_remote_rake "p2c:clone:intranet_dev"
      end
      desc "runs p2c:clone:moose remotely"
      task :moose do
        run_remote_rake "p2c:clone:moose"
      end
      desc "runs p2c:clone:pat_dev remotely"
      task :pat_dev do
        run_remote_rake "p2c:clone:pat_dev"
      end
      desc "runs p2c:clone:all remotely"
      task :all do
        run_remote_rake "p2c:clone:all"
      end
    end
    namespace :dump do
      desc "runs p2c:dump:pat remotely"
      task :pat do
        run_remote_rake "p2c:dump:pat"
      end
      desc "runs p2c:dump:pat_dev remotely"
      task :pat_dev do
        run_remote_rake "p2c:dump:pat_dev"
      end
      desc "runs p2c:dump:emu remotely"
      task :emu do
        run_remote_rake "p2c:dump:emu"
      end
      desc "runs p2c:dump:moose remotely"
      task :moose do
        run_remote_rake "p2c:dump:moose"
      end
      desc "runs p2c:dump:pulse remotely"
      task :pulse do
        run_remote_rake "p2c:dump:pulse"
      end
      desc "runs p2c:dump:intranet remotely"
      task :intranet do
        run_remote_rake "p2c:dump:intranet"
      end
      desc "runs p2c:dump:intranet_dev remotely"
      task :intranet_dev do
        run_remote_rake "p2c:dump:intranet_dev"
      end
      desc "runs p2c:dump:all remotely"
      task :all do
        run_remote_rake "p2c:dump:all"
      end
    end
    namespace :pull do
      desc "downloads and loads the pat db"
      task :pat do
        pull_db "pat", "summerprojecttool", "pat_prod"
      end
      desc "downloads and loads the pat dev db"
      task :pat_dev do
        pull_db "pat_dev", "spt_dev", "pat_dev"
      end
      desc "downloads and loads the pulse db"
      task :pulse do
        pull_db "pulse", "emu", "pulse_prod"
      end
      desc "downloads and loads the emu db"
      task :emu do
        pull_db "emu", "emu_stage", "pulse_stage_emu"
      end
      desc "downloads and loads the moose db"
      task :moose do
        pull_db "moose", "emu_dev", "pulse_dev_moose"
      end
      desc "downloads and loads the intranet db"
      task :intranet do
        pull_db "intranet", "ciministry", "cim_prod"
      end
      desc "downloads and loads the intranet dev db"
      task :intranet_dev do
        pull_db "intranet_dev", "dev_campusforchrist", "cim_dev"
      end
      desc "downloads and loads all databases"
      task :all do
        pat
        pat_dev
        pulse
        emu
        moose
        intranet
        intranet_dev
      end
    end
  end
end

