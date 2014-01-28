# WebFont

WebFont is a Ruby library that will help you download fonts from Google. For now, we support only [Google Font](http://www.google.com/fonts).

## Installation

Add this line to your application's Gemfile:

    gem 'web_font'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install web_font

## Dependencies

WebFont depends on [wget](http://en.wikipedia.org/wiki/Wget). Make sure you have it installed first.

For Ubuntu:
```
sudo apt-get install wget
```

To download font from Google, you need to have [Google API Key](https://www.google.com/search?q=google+api+key), then set ``GOOGLE_API_KEY`` environment variable.

## Usage

```ruby
require 'web_font'

ENV['GOOGLE_API_KEY'] = '...'
WebFont::Data.path    = '/some/where/in/your/disk'

# First you need to have font index
WebFont::Data.download

# Then you can download font 'Open Sans' and store it in /users/foo
downloader = WebFont::Downloader.new
downloader.download('Open Sans', '/users/foo')

# You can also find font in index as well
finder = WebFont::Finder.new
finder.find('Open Sans')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
