require "spec_helper"

describe Lurn::Text::CountVectorizer do

  let(:documents) do
    [
      "The quick brown fox quick",
      "brown dogs are slow",
      "slower than quick dogs"
    ]
  end

  let(:options) { {} }

  let(:vectorizer) { described_class.new(documents, options) }

  describe "#vectors" do

    subject { vectorizer.vectors }

    let(:expected_vectors) do
      [
        [1,0,1,0,1,2,0,0,0],
        [0,1,1,1,0,0,1,0,0],
        [0,0,0,1,0,1,0,1,1]
      ]
    end

    it "returns the tokenized documents" do
      expect(subject).to eq expected_vectors
    end
  end
end
