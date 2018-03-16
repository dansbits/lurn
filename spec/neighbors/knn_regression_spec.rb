require "spec_helper"

describe Lurn::Neighbors::KNNRegression do

  describe "#predict" do
    let(:regression) { Lurn::Neighbors::KNNRegression.new 2 }

    let(:target) { [10,15,18] }
    let(:obs1) { [1,2,4] }
    let(:obs2) { [4,5,6] }
    let(:obs3) { [100,200,300] }

    let(:obs4) { [2,4,6]}

    before do
      regression.fit([obs1,obs2,obs3], target)
    end

    it "returns the average of the nearest neighbors" do
      expect(regression.predict(obs4)).to eq((10.0 + 15.0) / 2.0)
    end
  end

end
