require "spec_helper"

describe Lurn::NaiveBayes::BernoulliNaiveBayes do

  let(:classes) {
    %w[
      sports
      sports
      sports
      sports
      sports
      sports
      informatics
      informatics
      informatics
      informatics
      informatics
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
    [false,false,true,false,true,false,true,false],
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

  describe "#to_h" do

    let(:model) do
      m = Lurn::NaiveBayes::BernoulliNaiveBayes.new
      m.fit(vectors, classes)
      m
    end

    subject { model.to_h }

    let(:expected_hash) do
      {
        probability_matrix: model.probability_matrix.to_a,
        label_probabilities: model.label_probabilities,
        unique_labels: model.unique_labels
      }
    end

    it "returns a json representation of the model" do
      hash = subject
      expect(subject).to eq expected_hash
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

  describe "#max_probability" do
    let(:test_vector) { [true, false, false, true, true, true, false, true] }
    let(:expected_probability) { 0.9856572801976612 }

    it "returns the class with the highest probblility for each given document" do
      classifier.fit(vectors, classes)
      expect(classifier.max_probability(test_vector)).to eq(expected_probability)
    end
  end

  describe "#max_class" do
    let(:test_vector) { [true, false, false, true, true, true, false, true] }
    let(:expected_class) { "sports" }
    it "returns the class with the highest probblility for each given document" do
      classifier.fit(vectors, classes)
      expect(classifier.max_class(test_vector)).to eq(expected_class)
    end
  end
end
