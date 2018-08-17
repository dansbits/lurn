require "spec_helper"
require "awesome_print"

describe Lurn::NaiveBayes::MultinomialNaiveBayes do

  let(:classes) {
    %w[china china china japan]
  }


  let(:vectors) {
    # vocab
    # chinese beijing shanghai macao tokyo japan
    [
      [2,1,0,0,0,0],   # china
      [2,0,1,0,0,0],   # china
      [1,0,0,1,0,0],   # china
      [1,0,0,0,1,1],   # japan
  ]}

  let(:classifier) { described_class.new }

  describe "#fit" do
    it "trains the model" do
      classifier.fit(vectors, classes)

      expect(classifier.prior_probabilities).to eq [3.0 / 4.0, 1.0 / 4.0]
      china_vector = [6.0 / 14.0, 2.0 / 14.0, 2.0 / 14.0, 2.0 / 14.0, 1.0 / 14.0, 1.0 / 14.0]
      expect(classifier.probability_matrix[0]).to eq china_vector.map { |p| Math.log(p) }

      japan_vector = [2.0/9.0,1.0/9.0,1.0/9.0,1.0/9.0,2.0/9.0,2.0/9.0]
      expect(classifier.probability_matrix[1]).to eq japan_vector.map { |p| Math.log(p) }
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

    let(:test_vector) { [3,0,0,0,1,1] }

    let(:expected_probabilities) { [-0.3714135806223897, -1.1704046127797412] }
    it "returns the class with the highest probblility for each given document" do
      classifier.fit(vectors, classes)
      expect(classifier.predict_log_probabilities(test_vector)).to eq(expected_probabilities)
    end
  end

  describe "#predict_probabilities" do

    let(:test_vector) { [3,0,0,0,1,1] }

    let(:expected_probabilities) { [Math.exp(-0.3714135806223897), Math.exp(-1.1704046127797412)] }

    it "returns the class with the highest probblility for each given document" do
      classifier.fit(vectors, classes)
      expect(classifier.predict_probabilities(test_vector)).to eq(expected_probabilities)
    end
  end

  describe "#max_probability" do
    let(:test_vector) { [3,0,0,0,1,1] }
    let(:expected_probability) { Math.exp(-0.3714135806223897) }

    it "returns the class with the highest probblility for each given document" do
      classifier.fit(vectors, classes)
      expect(classifier.max_probability(test_vector)).to eq(expected_probability)
    end
  end

  describe "#max_class" do
    let(:test_vector) { [3,0,0,0,1,1] }
    let(:expected_class) { "china" }

    it "returns the class with the highest probablility for each given document" do
      classifier.fit(vectors, classes)
      expect(classifier.max_class(test_vector)).to eq(expected_class)
    end
  end
end
