require './test/test_helper'

describe WebFont::Downloader do

  let(:destination_path) { "#{WebFont.test_root}/output" }
  before { FileUtils.rm(Dir.glob("#{destination_path}/*.ttf")) }
  after { FileUtils.rm(Dir.glob("#{destination_path}/*.ttf")) }

  describe '#download' do

    describe 'when fonts do not exist in local cache' do
      before { FileUtils.rm(Dir.glob("#{WebFont.test_root}/local_cache/*.ttf")) }
      after { FileUtils.rm(Dir.glob("#{WebFont.test_root}/local_cache/*.ttf")) }

      it 'downloads all fonts in the item' do
        downloader = WebFont::Downloader.new
        fonts = downloader.download('Open Sans', destination_path)

        Dir.glob(File.join(destination_path, '*.ttf')).size.must_equal 10
        Dir.glob(File.join(destination_path, '*.ttf')).size.must_equal fonts.size
      end
    end

    describe 'when fonts are in local cache' do
      before do
        FileUtils.copy(Dir.glob('test/fonts/*.ttf'), 'test/local_cache/')
        FileUtils.rm(Dir.glob(File.join(destination_path, '*')))
      end
      after { FileUtils.rm(Dir.glob("#{WebFont.test_root}/local_cache/*.ttf")) }

      it 'calls FileUtils 10 times' do
        FileUtils.expects(:copy).with(instance_of(String), instance_of(String)).times(10)

        downloader = WebFont::Downloader.new
        downloader.download('Open Sans', destination_path)
      end

      it 'copies files from local cache' do
        Dir.glob('test/fonts/*.ttf').size.must_equal 11

        downloader = WebFont::Downloader.new
        fonts = downloader.download('Open Sans', destination_path)

        Dir.glob(File.join(destination_path, '*.ttf')).size.must_equal 10
        Dir.glob(File.join(destination_path, '*.ttf')).size.must_equal fonts.size
      end
    end
  end
end
