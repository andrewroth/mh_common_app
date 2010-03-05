def run_coverage(files, custom_params=nil)
  rm_f "coverage"
  rm_f "coverage.data"
  
  # turn the files we want to run into a string
  if files.empty?
    puts "No files were specified for testing"
    return
  end
  
  files = files.join(" ")

  if RUBY_PLATFORM =~ /darwin/
    exclude = '--exclude "gems/*" --exclude "Library/Frameworks/*"'
  elsif RUBY_PLATFORM =~ /java/
    exclude = '--exclude "rubygems/*,jruby/*,parser*,gemspec*,_DELEGATION*,eval*,recognize_optimized*,yaml,yaml/*,fcntl"'
  else
    exclude = '--exclude "rubygems/*"'
  end
  # rake test:units:rcov SHOW_ONLY=models,controllers,lib,helpers
  # rake test:units:rcov SHOW_ONLY=m,c,l,h
  if ENV['SHOW_ONLY']
    params = String.new
    show_only = ENV['SHOW_ONLY'].to_s.split(',').map{|x|x.strip}
    if show_only.any?
      reg_exp = []
      for show_type in show_only
        reg_exp << case show_type
        when 'm', 'models' then 'app\/models'
        when 'c', 'controllers' then 'app\/controllers'
        when 'h', 'helpers' then 'app\/helpers'
        when 'l', 'lib' then 'lib'
        else
          show_type
        end
      end
      reg_exp.map!{ |m| "(#{m})" }
      params << " --exclude \"^(?!#{reg_exp.join('|')})\""
    end
    exclude = exclude + params
  end

  rcov_bin = RUBY_PLATFORM =~ /java/ ? "jruby -S rcov" : "rcov"
  rcov = "#{rcov_bin} --rails -Ilib:test --sort coverage --text-report #{exclude} #{custom_params}"
  puts
  puts
  puts "Running tests..."
  cmd = "#{rcov} #{files}"
  puts cmd
  sh cmd
end

namespace :test do
  
  desc "Measures unit, functional, and integration test coverage"
  task :coverage do
    run_coverage Dir["test/unit/**/*.rb", "test/functional/**/*.rb", "test/integration/**/*.rb"]
  end
  
  namespace :coverage do
    desc "Runs coverage on unit tests"
    task :units do
      run_coverage Dir["test/unit/**/*.rb"]
    end
    
    desc "Runs coverage on functional tests"
    task :functionals do
      run_coverage Dir["test/functional/**/*.rb"]
    end
    
    desc "Runs coverage on integration tests"
    task :integration do
      run_coverage Dir["test/integration/**/*.rb"]
    end
    
    namespace :plugin do
      desc "Runs coverage on a plugin's unit tests, must set PLUGIN=[plugin name]"
      task :units do
        if ENV['PLUGIN']
          params = %|--exclude "^(?!(#{ENV['PLUGIN']}))" --include-file /#{ENV['PLUGIN']}/|
          run_coverage Dir["test/unit/**/*.rb"], params
        else
          puts "Must set PLUGIN=[plugin name]"
        end
      end
    end
  end
end




