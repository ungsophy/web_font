gem 'minitest'
require 'minitest/autorun'

require 'web_font'
WebFont::Data.path = File.join(WebFont.test_root, 'data', 'google')
