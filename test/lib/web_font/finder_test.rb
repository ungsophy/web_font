require './test/test_helper'

describe WebFont::Finder do
  let(:finder) { WebFont::Finder.new }

  describe '#find' do
    it 'returns font data when it found one' do
      font_name = 'Open Sans'
      item      = finder.find(font_name)

      item['family'].must_equal font_name
    end

    it 'returns nil when nothing is found' do
      font_name = 'Arial'
      item      = finder.find(font_name)

      item.must_be_empty
    end
  end
end
