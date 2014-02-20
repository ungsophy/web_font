module WebFont
  class Downloader

    attr_reader :finder

    def initialize
      @finder = WebFont::Finder.new
    end

    # Download font from Google and save it locally
    #
    # Returns nothing
    def download(font_family, destination_path)
      item = finder.find(font_family)

      return if item.empty?

      font_family = item['family'].gsub(/\s/, '-')

      item['files'].each do |variant, url|
        filename = File.join(destination_path, "#{font_family}-#{variant}")
        extname  = File.extname(url)
        font     = "#{filename}#{extname}"

        WebFont::Command.wget(url, font) unless File.exist?(font)
      end
    end
  end
end
