require "rake"
require "hanami/rake_tasks"
require "rake/testtask"
Dir["lib/tasks/**/*.rb"].each { |f| load f }

unless ENV['HANAMI_ENV'] == 'production'
  Rake::TestTask.new do |t|
    t.pattern = "spec/**/*_spec.rb"
    t.libs << "spec"
  end

  task default: :test
  task spec: :test
end
