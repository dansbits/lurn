require_relative "spec_helper"

describe Lurn::WordTokenizer do

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

end
