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

      expect(classifier.probability_matrix.row(0)).to eq Vector[0.5, 0.25, 0.375, 0.5, 0.5, 0.625, 0.625, 0.625]
      expect(classifier.probability_matrix.row(1)).to eq Vector[2.0 / 7.0, 4.0 / 7.0, 4.0 / 7.0, 2.0 / 7.0, 2.0 / 7.0, 2.0 / 7.0, 4.0 / 7.0, 2.0 / 7.0]

      expect(classifier.label_probbilities).to eq [6.0 / 11.0, 5.0 / 11.0]
    end
  end

  describe "#predict" do
    it "returns the class with the highest probblility for each given document" do
      classifier.fit(vectors, classes)
      expect(classifier.predict([true, false, false, true, true, true, false, true])).to eq({"sports"=>0.9941037938060029, "informatics"=>0.22766145652867642})
    end
  end
end
