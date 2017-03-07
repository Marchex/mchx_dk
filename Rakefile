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
