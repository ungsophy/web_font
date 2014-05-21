require 'rake/tasklib'

require 'web_font'

module WebFont
  class CacheTask < Rake::TaskLib
    attr_accessor :name, :verbose

    def self.define_tasks!
      new
    end

    def initialize
      define_tasks
    end

    private

      def define_tasks
        namespace :web_font do
          desc 'Download google fonts'
          task :cache_fonts do
            WebFont::Index.download

            downloader = WebFont::Downloader.new
            cache_path = WebFont::LocalCache.cache_path

            unless WebFont::LocalCache.cache
              raise 'WebFont::LocalCache.cache is false.'
            end

            if cache_path
              FileUtils.mkdir_p(cache_path) if !Dir.exist?(cache_path)
            else
              raise 'WebFont::LocalCache.cache_path is empty.'
            end

            file_path  = "#{WebFont::Index.path}/fonts.json"
            hash       = JSON.parse(File.open(file_path).read)

            hash['items'].each_with_index do |item, index|
              family = item['family']

              puts family

              downloader.download(family, cache_path, false)
            end

            puts "\n"
            puts '=' * 50
            puts 'ALL FONTS ARE DOWNLOADED...'
            puts '=' * 50
          end
        end
      end
  end
end
