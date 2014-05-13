gem 'minitest'

require 'minitest/autorun'
require 'mocha/setup'

require 'pp'

require 'web_font'

WebFont::Index.path = File.join(WebFont.test_root, 'index', 'google')

WebFont::LocalCache.cache      = true
WebFont::LocalCache.cache_path = 'test/local_cache'
