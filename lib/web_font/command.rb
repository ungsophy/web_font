module WebFont
  module Command
    def self.wget(url, output_path)
      system("wget -q -O #{output_path} #{url}")
    end
  end
end
