namespace :cruise do
  task :prepare do
    ENV['PLUGIN'] = "mh_common/lib/common/core/ca/\\|mh_common/lib/legacy/\\|mh_common/lib/pulse/"
  end
end

task :cruise => [ "cruise:prepare", "test:coverage:plugin:units" ] do
end
