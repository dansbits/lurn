require "spec_helper"
require "awesome_print"

describe Lurn::NaiveBayes::BernoulliNaiveBayes do

  let(:classes) {
    [
      'sports',
      'sports',
      'sports',
      'sports',
      'sports',
      'sports',
      'informatics',
      'informatics',
      'informatics',
      'informatics',
      'informatics'
    ]
  }

  let(:vectors) { [
    [true,false,false,false,true,true,true,true],   # sports
    [false,false,true,false,true,true,false,false], # sports
    [false,true,false,true,false,true,true,false],  # sports
    [true,false,false,true,false,true,false,true],  # sports
    [true,false,false,false,true,false,true,true],  # sports
    [false,false,true,true,false,false,true,true],  # sports
    [false,true,true,false,false,false,true,false],
    [true,true,false,true,false,false,true,true],
    [false,true,true,false,false,true,false,false],
    [false,false,false,false,false,false,false,false],
    [false,false,true,false,true,false,true,false]
  ]}

  let(:classifier) { described_class.new }

  describe "#fit" do
    it "trains the model" do
      classifier.fit(vectors, classes)

      expect(classifier.probability_matrix.row(0)).to eq Vector[0.5, 0.25, 0.375, 0.5, 0.5, 0.625, 0.625, 0.625].map { |p| Math.log(p) }
      expect(classifier.probability_matrix.row(1)).to eq Vector[2.0 / 7.0, 4.0 / 7.0, 4.0 / 7.0, 2.0 / 7.0, 2.0 / 7.0, 2.0 / 7.0, 4.0 / 7.0, 2.0 / 7.0].map { |p| Math.log(p) }

      expect(classifier.label_probabilities).to eq [6.0 / 11.0, 5.0 / 11.0]
    end
  end

  describe "#predict_log_probabilities" do

    let(:test_vector) { [true, false, false, true, true, true, false, true] }
    let(:expected_probabilities) { [-0.014446570807947978, -4.244512796359803] }
    it "returns the class with the highest probblility for each given document" do
      classifier.fit(vectors, classes)
      expect(classifier.predict_log_probabilities(test_vector)).to eq(expected_probabilities)
    end
  end

  describe "#predict_probabilities" do

    let(:test_vector) { [true, false, false, true, true, true, false, true] }
    let(:expected_probabilities) { [0.9856572801976612, 0.014342719802338963] }
    it "returns the class with the highest probblility for each given document" do
      classifier.fit(vectors, classes)
      expect(classifier.predict_probabilities(test_vector)).to eq(expected_probabilities)
    end
  end
end
