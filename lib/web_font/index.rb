module WebFont
  module Index

    class << self
      attr_accessor :path
    end

    # Download font index from Google, save it locally and index it.
    #
    # fonts.json schema:
    # {
    #   "kind": "webfonts#webfontList",
    #   "items": [
    #     {
    #       "kind": "webfonts#webfont",
    #       "family": "ABeeZee",
    #       "variants": [
    #         "regular",
    #         "italic"
    #       ],
    #       "subsets": [
    #         "latin"
    #       ],
    #       "version": "v1",
    #       "lastModified": "2013-12-16",
    #       "files": {
    #         "regular": "http://themes.googleusercontent.com/static/fonts/abeezee/v1/mE5BOuZKGln_Ex0uYKpIaw.ttf",
    #         "italic": "http://themes.googleusercontent.com/static/fonts/abeezee/v1/kpplLynmYgP0YtlJA3atRw.ttf"
    #       }
    #     },
    #     { ... },
    #     { ... }
    #   ]
    # }
    #
    # Returns nothing
    def self.download
      raise 'WebFont::Index.path is empty' unless path
      raise "ENV['GOOGLE_API_KEY'] is empty" unless ENV['GOOGLE_API_KEY']

      FileUtils.mkdir_p(path) unless Dir.exist?(path)

      url         = "https://www.googleapis.com/webfonts/v1/webfonts?key=#{ENV['GOOGLE_API_KEY']}"
      output_path = "#{path}/fonts.json"
      Command.wget(url, output_path)

      index
    end

    private

      # Index font data so it will speed things up when searching
      #
      # Returns nothing
      def self.index
        indices           = {}
        alphabet          = 'a'
        indices[alphabet] = { 'start' => 0 }

        hash = JSON.parse(File.open("#{path}/fonts.json").read)
        hash['items'].each_with_index do |item, index|
          family = item['family']

          if family[0].downcase != alphabet
            indices[alphabet]['end'] = index - 1

            alphabet = family[0].downcase
            indices[alphabet] = { 'start' => index }
          end
        end
        indices[alphabet]['end'] = hash['items'].size - 1

        File.open("#{path}/index.json", 'w') { |file| file.write(indices.to_json) }
      end
  end
end
