require 'json'
require 'fileutils'
require 'net/http'

require 'web_font/version'
require 'web_font/http'
require 'web_font/downloader'
require 'web_font/index'
require 'web_font/finder'
require 'web_font/local_cache'

module WebFont
  def self.root
    File.expand_path('..', __FILE__)
  end

  def self.test_root
    File.expand_path('../../test', __FILE__)
  end
end

WebFont::LocalCache.cache = true
