require './test/test_helper'

describe WebFont::Finder do
  let(:finder) { WebFont::Finder.new }

  describe '#find' do
    it 'returns font data when it found one' do
      font_name = 'Open Sans'
      item      = finder.find('Open Sans')

      item['family'].must_equal font_name
    end

    it 'returns nil when nothing is found' do
      font_name = 'Arial'
      item      = finder.find(font_name)

      item.must_be_empty
    end

    it 'returns {} when nothing is found' do
      font_name = '27Arial'
      item      = finder.find(font_name)

      item.must_be_empty
      finder.find('').must_be_empty
      finder.find(nil).must_be_empty
    end
  end

  describe '#info' do
    it 'returns font info' do
      info = finder.info('Open Sans')

      info.must_equal ['Open-Sans-300.ttf', 'Open-Sans-300italic.ttf',
                       'Open-Sans-regular.ttf', 'Open-Sans-italic.ttf',
                       'Open-Sans-600.ttf', 'Open-Sans-600italic.ttf',
                       'Open-Sans-700.ttf', 'Open-Sans-700italic.ttf',
                       'Open-Sans-800.ttf', 'Open-Sans-800italic.ttf']
    end

    describe 'when font is not available' do
      it 'returns empty array' do
        info = finder.info('Arial')

        info.must_be_empty
      end
    end
  end
end
