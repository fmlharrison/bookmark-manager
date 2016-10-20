require 'rspec/core/rake_task'

require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'app/app'

RSpec::Core::RakeTask.new :spec

task default: [:spec]

namespace :db do
  task :autoupdate do
    puts "Upgrading database"
    DataMapper.auto_upgrade!
  end

  task :automigrate do
    puts "Migrating database"
    DataMapper.auto_migrate!
  end
end
