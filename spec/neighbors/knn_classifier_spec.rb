require "spec_helper"

describe Lurn::Neighbors::KNNClassifier do

  describe "#predict" do
    let(:regression) { Lurn::Neighbors::KNNClassifier.new 3 }

    let(:target) { ['boats','cars','boats','cars'] }
    let(:obs1) { [1,2,4] }
    let(:obs2) { [4,5,6] }
    let(:obs3) { [4,6,8] }
    let(:obs4) { [100,200,300] }

    let(:obs5) { [2,4,6]}

    before do
      regression.fit([obs1,obs2,obs3,obs4], target)
    end

    it "returns the average of the nearest neighbors" do
      expect(regression.predict(obs5)).to eq('boats')
    end

  end

end
