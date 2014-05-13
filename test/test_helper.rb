gem 'minitest'
require 'minitest/autorun'
require 'pp'

require 'web_font'
WebFont::Data.path = File.join(WebFont.test_root, 'data', 'google')

WebFont::LocalCache.cache      = true
WebFont::LocalCache.cache_path = './test/local_cache'
