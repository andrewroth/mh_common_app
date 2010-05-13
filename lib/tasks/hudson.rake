task :hudson => [ "test:mh_common:lock" ] do
  begin
    #ENV['PLUGIN'] = "mh_common/lib/common/core/ca/\\|mh_common/lib/legacy/\\(accountadmin\\|hrdb\\|site\\|stats\\)\\|mh_common/lib/pulse/"
    ENV['PLUGIN'] = "mh_common"
    ENV['AGGREGATE'] = "coverage/aggregate.data"
    Rake::Task["test:coverage:plugin:units"].execute
  rescue
    $logger.info "In rescue block"
    raise
  ensure
    Rake::Task["test:mh_common:lock:release"].execute
  end
end
