module WebFont
  module LocalCache
    class << self
      attr_accessor :cache, :cache_path

      def path(filename)
        path = File.join(cache_path, filename)
        File.exist?(path) ? path : nil
      end

      def save(font)
        return nil unless cache_path

        filename = File.basename(font)
        path     = File.join(cache_path, filename)
        FileUtils.copy(font, path)

        path
      end

      def enable?
        cache && !!cache_path && Dir.exist?(cache_path)
      end
    end
  end
end
