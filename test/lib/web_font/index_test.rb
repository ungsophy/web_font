require './test/test_helper'

describe WebFont::Index do
  describe '.download' do

    it 'download google fonts data and creates index.json' do
      WebFont::Index.download

      File.exist?("#{WebFont::Index.path}/fonts.json").must_equal true
      File.exist?("#{WebFont::Index.path}/index.json").must_equal true

      file    = File.open("#{WebFont::Index.path}/index.json")
      indices = JSON.parse(file.read)
      file.close

      start = 0
      indices.each do |alphabet, hash|
        if alphabet == 'a'
          hash['start'].must_equal 0
        else
          hash['start'].must_equal start
        end

        start = hash['end'] + 1
      end
    end
  end
end
