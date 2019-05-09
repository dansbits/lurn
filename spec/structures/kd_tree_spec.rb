require "spec_helper"

module Lurn

  describe KdTree do
    describe "initializer" do

      let(:v0) { [1,3,5] }
      let(:v1) { [2,4,6] }
      let(:v2) { [1,4,7] }
      let(:vectors) { [v0,v1,v2] }

      let(:tree) { KdTree.new(vectors) }

      it "builds the right tree" do
        expect(tree.partition_dimension).to eq 0
        expect(tree.partition).to eq 1
        left = tree.left_tree

        expect(left.partition).to eq 3
        expect(left.left_tree.vector).to eq v0
        expect(left.right_tree.vector).to eq v2
        
        right = tree.right_tree
        expect(right.vector).to eq v1
      end

      context "with duplicate vectors" do
        before { vectors.push v1 }
        it "stores a count on the node for that vector" do
          right = tree.right_tree
          expect(right.vector).to eq v1
          expect(right.vector_count).to eq 2
        end
      end
    end
  end
end