# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

desc "Run all tests and features"
task :default => [:test, :features]

begin
  gem 'lipsiadmin'
  require 'lipsiadmin_tasks'
rescue Gem::LoadError
end

