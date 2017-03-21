require "spec_helper"

module Lurn
  module Evaluation
    describe ClassifierEvaluator do

      let(:predicted) { %w[ SPAM SPAM HAM SPAM SPAM  HAM HAM  SPAM ] }
      let(:actual) {    %w[ SPAM HAM  HAM HAM  SPAM HAM SPAM SPAM ] }

      subject { Lurn::Evaluation::ClassifierEvaluator.new(predicted, actual) }

      describe "#unique_classes" do
        it "returns the unique classes" do
          expect(subject.unique_classes).to eq %w[ SPAM HAM ]
        end
      end

      describe "#precision" do

        it "returns the computed precision for the given class" do
          expect(subject.precision('SPAM')).to eq 0.6
        end
      end

      describe "#recall" do
        it "returns the calculated recall for the class" do
          expect(subject.recall('SPAM')).to eq 0.75
        end
      end
    end
  end
end