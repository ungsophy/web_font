require 'bundler/gem_tasks'
require 'rake/testtask'
require 'web_font/cache_task'

Rake::TestTask.new do |t|
  t.pattern = './test/lib/**/*_test.rb'
end
task default: :test

# ENV['GOOGLE_API_KEY']        ||= ''
WebFont::Index.path            = File.join(__dir__, 'cache', 'index')

WebFont::LocalCache.cache      = true
WebFont::LocalCache.cache_path = File.join(__dir__, 'cache', 'fonts')

WebFont::CacheTask.define_tasks!
