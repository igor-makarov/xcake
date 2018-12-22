require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task :spec do
  begin
    sh "bundle exec rspec #{specs('**')}"
  rescue RuntimeError
    STDERR.puts "Tests failed!"
    exit 1
  end
end

RuboCop::RakeTask.new

task :all do
  title 'Running tests'
  Rake::Task['spec'].invoke

  title 'Checking code style'
  Rake::Task['rubocop'].invoke
end

task default: :all

# Helpers
#-----------------------------------------------------------------------------#

def specs(dir)
  FileList["spec/#{dir}/*_spec.rb"].shuffle.join(' ')
end

def title(title)
  cyan_title = "\033[0;36m#{title}\033[0m"
  puts
  puts '-' * 80
  puts cyan_title
  puts '-' * 80
  puts
end
