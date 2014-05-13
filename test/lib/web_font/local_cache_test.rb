require './test/test_helper'

describe WebFont::LocalCache do
  before do
    WebFont::LocalCache.cache      = true
    WebFont::LocalCache.cache_path = 'test/local_cache'

    FileUtils.rm_rf([File.join(WebFont::LocalCache.cache_path, '.')])
  end

  describe '.enable?' do
    describe 'when cache is true and cache_path is exist' do
      it 'returns true' do
        WebFont::LocalCache.enable?.must_equal true
      end
    end

    describe 'when cache is false and cache_path is exist' do
      before { WebFont::LocalCache.cache = false }

      it 'returns true' do
        WebFont::LocalCache.enable?.must_equal false
      end
    end

    describe 'when cache is true and cache_path is not exist' do
      before { WebFont::LocalCache.cache_path = 'test/not_exist' }

      it 'returns true' do
        WebFont::LocalCache.enable?.must_equal false
      end
    end
  end

  describe '.save' do
    it 'saves font in local directory' do
      font_name = 'suwannaphum.ttf'
      WebFont::LocalCache.save("test/data/fonts/#{font_name}")

      File.exist?("test/local_cache/#{font_name}").must_equal true
    end
  end

  describe '.path' do
    describe 'when font does not exist in local cache' do
      it 'returns nil' do
        path = WebFont::LocalCache.path('font-name.tff')

        path.must_be_nil
      end
    end

    describe 'when font exist in local cache' do
      before { FileUtils.copy('test/data/fonts/suwannaphum.ttf', 'test/local_cache') }

      it 'returns path' do
        filename = 'suwannaphum.ttf'
        path     = WebFont::LocalCache.path(filename)

        path.must_equal "test/local_cache/#{filename}"
      end
    end
  end
end
