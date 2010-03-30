namespace :cruise do
  task :prepare do
    ENV['PLUGIN'] = "mh_common/lib/common/core/ca/\\|mh_common/lib/legacy/\\|mh_common/lib/pulse/"
    $lock_path = File.expand_path("~/.cruise/mh_common_lock")
    while File.exists?($lock_path)
      puts "Detected another test going on.  Waiting 30 seconds."
      sleep 30
    end
    $lock = File.open($lock_path, "w")
  end
end

task :cruise => [ "cruise:prepare", "test:coverage:plugin:units" ] do
  $lock.close
  File.delete($lock_path)
end
