require "spec_helper"

describe Lurn::Text::WordCountVectorizer do

  let(:documents) do
    [
      "The quick brown fox quick",
      "brown dogs are slow",
      "slower than quick dogs",
    ]
  end

  let(:options) { {} }

  let(:vectorizer) { Lurn::Text::WordCountVectorizer.new(options) }

  let(:expected_vocab) { %w[ The are brown dogs fox quick slow slower than ] }

  describe "#fit" do

    subject { vectorizer.fit(documents) }

    it "builds the vocabulary based on the provided documents" do
      expect(vectorizer.vocabulary).to eq []
      subject
      expect(vectorizer.vocabulary).to eq expected_vocab
    end

    context "when the vectorizer was previously trained" do
      before { vectorizer.fit( ["different words", "dont match"] ) }

      let(:previous_vocab) { %w[ different dont match words ] }

      it "overwrites the previous vocabulary" do
        expect{ subject }.to change { vectorizer.vocabulary }.from(previous_vocab).to(expected_vocab)
      end
    end

    describe "options" do
      describe "max_df" do
        let(:documents) do
          [
            "firefox is mozilla's browser",
            "edge is microsoft's browser",
            "chrome is google's browser",
            "safari is apple's browser",
          ]
        end

        let(:expected_vocab) { %w[ firefox mozilla's edge microsoft's chrome google's safari apple's ] }

        let(:options) { { max_df: 3 }}

        it "removes words which appear in more than max_df documents" do
          subject
          expect(vectorizer.vocabulary).to match_array expected_vocab
        end
      end

      describe "min_df" do
        let(:documents) do
          [
            "firefox is mozilla's browser",
            "edge is microsoft's browser",
            "chrome is google's browser",
            "safari is apple's browser",
          ]
        end

        let(:expected_vocab) { %w[ is browser ] }

        let(:options) { { min_df: 3 } }

        it "removes words which appear in fewer than min_df documents" do
          subject
          expect(vectorizer.vocabulary).to match_array expected_vocab
        end
      end
    end
  end

  describe "#to_h" do

    let(:expected_hash) {
      {
        tokenizer_options: { strip_punctuation: false, strip_stopwords: false, stem_words: false, ngrams: 1 },
        vocabulary: expected_vocab
      }
    }

    before { vectorizer.fit(documents) }

    it "returns a hash representation of the vectorizer" do
      expect(vectorizer.to_h).to eq expected_hash
    end
  end

  describe "#transform" do

    before { vectorizer.fit(documents) }

    subject { vectorizer.transform(documents) }

    let(:expected_vectors) do
      [
        #The  are   brown dogs  fox  quick slow  slower than
        [1,   0,    1,    0,    1,   2,    0,    0,     0],
        [0,   1,    1,    1,    0,   0,    1,    0,     0],
        [0,   0,    0,    1,    0,   1,    0,    1,     1],
      ]
    end

    it "returns the tokenized documents" do
      expect(subject).to eq expected_vectors
    end
  end

end
