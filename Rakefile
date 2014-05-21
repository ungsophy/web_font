require 'bundler/gem_tasks'
require 'rake/testtask'
require 'web_font/cache_task'

Rake::TestTask.new do |t|
  t.pattern = './test/lib/**/*_test.rb'
end
task default: :test

ENV['GOOGLE_API_KEY']        ||= 'AIzaSyDhMw8jN0DSS6mLn17fRgMYPcOLblDD3XY'
WebFont::Index.path            = File.expand_path('../cache/index', __FILE__)

WebFont::LocalCache.cache      = true
WebFont::LocalCache.cache_path = File.expand_path('../cache/fonts', __FILE__)

WebFont::CacheTask.define_tasks!
