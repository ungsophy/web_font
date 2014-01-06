require './test/test_helper'

describe WebFont::Downloader do

  let(:destination_path) { "#{WebFont.test_root}/output" }
  before { FileUtils.rm(Dir.glob("#{destination_path}/*.ttf")) }
  after { FileUtils.rm(Dir.glob("#{destination_path}/*.ttf")) }

  describe '#download' do
    it 'downloads all fonts in the item' do
      downloader = WebFont::Downloader.new
      downloader.download('Open Sans', destination_path)

      Dir.glob(File.join(destination_path, '*.ttf')).size.must_equal 10
    end
  end
end
