require "spec_helper"

describe Lurn::CountVectorizer do

  let(:documents) do
    [
      "The quick brown fox",
      "brown dogs are slow",
      "slower than quick dogs"
    ]
  end

  let(:options) { {} }

  let(:vectorizer) { described_class.new(documents, options) }

  describe "#vectors" do

    subject { vectorizer.vectors }

    let(:expected_vectors) do
      counts = {
        "The" => [1,0,0],
        "quick" => [1,0,1],
        "brown" => [1,1,0],
        "fox" => [1,0,0],
        "dogs" => [0,1,1],
        "are" => [0,1,0],
        "slow" => [0,1,0],
        "slower" => [0,0,1],
        "than" => [0,0,1],
      }

      Daru::DataFrame.new(counts)
    end

    it "returns the tokenized documents" do
      expect(subject).to eq expected_vectors
    end
  end
end
