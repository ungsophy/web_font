require 'json'
require 'fileutils'

module WebFont
  module Data

    class << self
      attr_accessor :path
    end

    # Download fonts data from Google and index it
    #
    # Returns nothing
    def self.download
      assert_path!
      raise ArgumentError, "ENV['GOOGLE_API_KEY'] is nil" unless ENV['GOOGLE_API_KEY']

      FileUtils.mkdir_p(path) unless Dir.exist?(path)

      url = "https://www.googleapis.com/webfonts/v1/webfonts?key=#{ENV['GOOGLE_API_KEY']}"
      system("wget -O #{path}/fonts.json #{url}")

      index
    end

    def self.assert_path!
      raise ArgumentError, 'path is empty' unless path
    end

    private

    # Index fonts data so it will speed things up when search
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
