require "spec_helper"

describe Lurn::Neighbors::KNNBase do

  describe "#fit" do
    let(:regression) { Lurn::Neighbors::KNNBase.new(2) }
    let(:target) { [3,4] }
    let(:obs1) { [2,3,4] }
    let(:obs2) { [4,5,6] }
    let(:predictors) { [obs1, obs2] }

    subject { regression.fit(predictors, target) }

    it "stores targets and converts predictors into vectors" do
      subject
      expect(regression.predictors).to eq([Vector.elements(obs1), Vector.elements(obs2)])
      expect(regression.targets).to eq target
    end
  end

  describe "#nearest_neighbors" do
    let(:regression) { Lurn::Neighbors::KNNBase.new(2) }
    let(:target) { [3,4,5] }
    let(:obs1) { [1,2,3] }
    let(:obs2) { [7,8,9] }
    let(:obs3) { [20,25,30] }

    let(:obs4) { [4,5,6] }

    let(:predictors) { [obs1, obs2, obs3] }

    subject { regression.nearest_neighbors(obs4) }

    before { regression.fit(predictors, target) }

    it "stores targets and converts predictors into vectors" do
      k_predictors, k_targets = subject
      expect(k_predictors).to eq([Vector.elements(obs1), Vector.elements(obs2)])
      expect(k_targets).to eq [3,4]
    end
  end

end
