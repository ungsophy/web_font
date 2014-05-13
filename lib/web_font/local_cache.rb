module WebFont
  module LocalCache
    class << self
      attr_accessor :cache, :cache_path

      def path(filename)
        path = File.join(cache_path, filename)
        File.exist?(path) ? path : nil
      end

      def save(font)
        filename = File.basename(font)
        FileUtils.copy(font, File.join(cache_path, filename))
      end

      def enable?
        cache && cache_path && Dir.exist?(cache_path)
      end
    end
  end
end
