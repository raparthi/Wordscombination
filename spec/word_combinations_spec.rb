require 'spec_helper'
describe do
  let!(:wc) { WordCombination.new }
  it 'shoud return data 6686787825' do
    data = wc.get_words('6686787825')
    [
      'motortruck',
      'noun,struck',
      'onto,struck',
      'motor,truck',
      'motor,usual',
      'nouns,truck',
      'nouns,usual',
      'not,opt,ruck',
      'not,opt,suck'
    ].each do |word|
      expect(data).to include(word)
    end
  end

  it 'shoud return array 2282668687' do
    data = wc.get_words('2282668687')
    [
      'catamounts',
      'acta,mounts',
      'act,amounts',
      'act,contour',
      'cat,boot,our'
    ].each do |word|
      expect(data).to include(word)
    end
  end

  it 'shoud return error when invalid number 9008457334' do
    data = wc.get_words('9008457334')
    expect(data).to include('Invalid phone number')
  end

  it 'shoud return error when invalid length number' do
    data = wc.get_words('9445845733454554')
    expect(data).to include('Invalid phone number')
  end
end
