require "spec_helper"
require "awesome_print"

describe Lurn::NaiveBayes::BernoulliNaiveBayes do

  let(:classes) { ['cats','dogs','cats', 'cats'] }
  let(:vectors) { [
    [true, false], # cats
    [false, true], # dogs
    [true, false], # cats
    [false, true]  # cats
  ]}

  let(:classifier) { described_class.new }

  describe "#fit" do
    it "trains the model" do
      classifier.fit(vectors, classes)

      ap classifier.labels
      expect(classifier.labels['cats'][:word_probabilities][0][:prob_label]).to eq 0.6
      expect(classifier.labels['cats'][:word_probabilities][0][:prob_not_label]).to be_within(0.001).of 0.333333333
    end
  end

  describe "#predict" do
    it "returns the class with the highest probblility for each given document" do
      classifier.fit(vectors, classes)
      # ap classifier.word_stats
      # ap classifier.classes
      expect(classifier.predict([true, false])).to eq({})
    end
  end
end
