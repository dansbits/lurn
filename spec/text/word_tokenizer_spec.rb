require "spec_helper"

describe Lurn::Text::WordTokenizer do

  let(:options) { {} }

  subject { described_class.new(options) }

  it "splits the document into words by splitting on white space" do
    expect(subject.tokenize("\nhello \tworld ")).to eq ["hello","world"]
  end

  context "when strip_punctuation is true" do
    let(:options) { { strip_punctuation: true } }

    it "removes punctuation from tokens" do
      expect(subject.tokenize("hello! world.")).to eq ["hello", "world"]
    end
  end

  context "when stem_words is true" do
    let(:options) { { stem_words: true } }

    it 'stems the words' do
      expect(subject.tokenize('my house is painted')).to eq ['my','hous','is','paint']
    end
  end

end
