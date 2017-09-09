require 'spec_helper'

describe Lurn::Text::BernoulliVectorizer do

  let(:documents) do
    [
      'The quick brown fox quick',
      'brown dogs are slow',
      'slower than quick dogs'
    ]
  end

  let(:options) { {} }

  let(:vectorizer) { described_class.new(options) }

  let(:expected_vocab) { ['The', 'are', 'brown', 'dogs', 'fox', 'quick', 'slow', 'slower', 'than'] }

  describe '#fit' do
    subject { vectorizer.fit(documents) }

    it 'builds the vocabulary based on the provided documents' do
      expect(vectorizer.vocabulary).to eq []
      subject
      expect(vectorizer.vocabulary).to eq expected_vocab
    end

    context 'when the vectorizer was previously trained' do
      before { vectorizer.fit(['different words','dont match']) }

      let(:previous_vocab) { ['different','dont','match','words'] }

      it 'overwrites teh previous vocabulary' do
        expect{ subject }.to change { vectorizer.vocabulary }.from(previous_vocab).to(expected_vocab)
      end
    end
  end

  describe '#to_h' do

    let(:expected_hash) {
      {
        tokenizer_options: { strip_punctuation: false, strip_stopwords: false },
        vocabulary: expected_vocab
      }
    }

    before { vectorizer.fit(documents) }

    it 'returns a hash representation of the vectorizer' do
      expect(vectorizer.to_h).to eq expected_hash
    end
  end

  describe '#transform' do

    before { vectorizer.fit(documents) }

    subject { vectorizer.transform(documents) }

    let(:expected_vectors) do
      [
        [true,false,true,false,true,true,false,false,false],
        [false,true,true,true,false,false,true,false,false],
        [false,false,false,true,false,true,false,true,true]
      ]
    end

    it 'returns the tokenized documents' do
      expect(subject).to eq expected_vectors
    end
  end

end
