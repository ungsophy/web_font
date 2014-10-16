module WebFont
  module HTTP
    def self.get(uri, output_path)
      json_str = Net::HTTP.get(URI(uri))
      File.open(output_path, 'w') { |fp| fp.puts(json_str) }
    end
  end
end
