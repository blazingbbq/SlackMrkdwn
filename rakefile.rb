begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:test)

  task :default => :test
rescue LoadError
end