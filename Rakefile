# require "bundler/setup"

task :default => [:list]

desc "Lists all the tasks."
task :list do
    puts "Tasks: \n- #{Rake::Task.tasks.join("\n- ")}"
end

desc "Checks for required dependencies."
task :check do
  sh "bundle check"
end

desc "Runs chefspec tests."
task :chefspec do
    sh "rspec spec"
end

desc "Runs kitchen tests."
task :kitchen do
    sh "kitchen test"
end

desc "Runs foodcritic."
task :foodcritic do
    sh "foodcritic ."
    sh "foodcritic . -G -t marchex"
end

desc "Runs rubocop."
task :rubocop do
    sh "rubocop ."
end

desc "Checks shell syntax."
task :syntax do
    sh "bash -n install.sh"
    sh "bash -n run_cookbook.sh"
end

desc "Run delivery verify tests."
task :dverify do
  sh "delivery job -l verify 'unit lint syntax'"
end

desc "Run delivery verify tests."
task :dkitchen do
  sh "delivery job -l acceptance functional"
end

desc "Run delivery verify tests."
task :delivery do
  Rake::Task[:dverify].execute
  Rake::Task[:dkitchen].execute
end

desc "Run validation tests."
task :lint do
  Rake::Task[:foodcritic].execute
  Rake::Task[:rubocop].execute
end

desc "Run unit tests."
task :unit do
  Rake::Task[:lint].execute
  Rake::Task[:chefspec].execute
  Rake::Task[:syntax].execute
end

desc "Run integration tests."
task :integration do
  Rake::Task[:chefspec].execute
  Rake::Task[:kitchen].execute
end

desc "Run all tests."
task :all do
  Rake::Task[:unit].execute
  Rake::Task[:kitchen].execute
end
