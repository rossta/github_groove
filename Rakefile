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

Rake::Task["assets:precompile"].clear
namespace :assets do
  task "precompile" do
    puts "Not pre-compiling assets..."
  end
end
