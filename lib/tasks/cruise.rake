task :cruise => [ "test:mh_common:lock" ] do
  begin
    Rake::Task["hudson"].execute
  ensure
    out = ENV['CC_BUILD_ARTIFACTS']
    $logger.info "ENV['CC_BUILD_ARTIFACTS'] = #{out}"
    if out
      FileUtils.mkdir_p(out) unless File.directory?(out)
      FileUtils.cp_r "coverage", out
    end
  end
end
