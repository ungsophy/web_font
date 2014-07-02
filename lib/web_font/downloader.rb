module WebFont
  class Downloader

    attr_reader :finder

    def initialize
      @finder = Finder.new
    end

    # Download font from Google and save it locally
    #
    # Returns nothing
    def download(font_family, destination_path, from_cache = true)
      downloaded_fonts = []
      item             = finder.find(font_family)
      return downloaded_fonts if item.empty?

      font_family      = item['family'].gsub(/\s/, '-')
      item['files'].each do |variant, url|
        filename  = "#{font_family}-#{variant}#{File.extname(url)}"
        font_path = File.join(destination_path, filename)

        if from_cache && LocalCache.enable? && cache_path = LocalCache.path(filename)
          FileUtils.copy(cache_path, destination_path)
          downloaded_fonts << font_path
        else
          unless File.exist?(font_path)
            Command.wget(url, font_path)
            LocalCache.save(font_path)
            downloaded_fonts << font_path
          end
        end
      end

      downloaded_fonts
    end
  end
end
