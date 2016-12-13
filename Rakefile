# require "bundler/setup"

task :default => [:list]

desc "List all the tasks."
task :list do
    puts "Tasks: \n- #{Rake::Task.tasks.join("\n- ")}"
end

desc "Check for (and resolve) required dependencies."
task :check do
  sh "bundle check || bundle install"
end

desc "Run chefspec tests."
task :chefspec do
    Rake::Task[:check].execute
    sh "bundle exec rspec spec"
end

desc "Run kitchen tests."
task :kitchen do
    Rake::Task[:check].execute
    sh "kitchen test"
end

desc "Run foodcritic."
task :foodcritic do
    Rake::Task[:check].execute
    sh "bundle exec foodcritic ." # runs all built-in foodcritic rules
    sh "bundle exec foodcritic . -G -t marchex_base" # marchex-specific rules
end

desc "Run rubocop."
task :rubocop do
    Rake::Task[:check].execute
    sh "bundle exec rubocop ."
end

desc "Checks shell syntax."
task :syntax do
    sh "bash -n install.sh"
    sh "bash -n run_cookbook.sh"
end

desc "Run validation tests."
task :lint do
  Rake::Task[:rubocop].execute
  Rake::Task[:foodcritic].execute
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

desc "Run delivery verify tests."
task :dverify do
  sh "delivery job -l verify 'unit lint syntax'"
end

desc "Run delivery verify tests."
task :delivery do
  Rake::Task[:dverify].execute
  Rake::Task[:dkitchen].execute
end
