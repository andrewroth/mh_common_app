namespace :cruise do
  task :prepare do
    ENV['PLUGIN'] = "mh_common/lib/common/core/ca/\\|mh_common/lib/legacy/\\|mh_common/lib/pulse/"
    while File.exists?("~/.cruise/mh_common_lock")
      puts "Detected another test going on.  Waiting 30 seconds."
      sleep 30
    end
    $lock = File.open("~/.cruise/mh_common_lock", "w")
  end
end

task :cruise => [ "cruise:prepare", "test:coverage:plugin:units" ] do
  $lock.close
end
