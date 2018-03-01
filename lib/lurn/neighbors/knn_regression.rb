module Lurn
  module Neighbors
    class KNNRegression

      attr_accessor :predictors, :targets, :k

      def initialize(k)
        @k = k
      end

      def fit(predictors, targets)
        @predictors = predictors.map { |pred| Vector.elements(pred) }
        @targets = targets
      end

      def predict(vector)
        vector = Vector.elements(vector)

        distances = @predictors.map.with_index do |p, index|
          { distance: euclidian_distance(p, vector), value: targets[index] }
        end

        distances.sort { |x,y| x[:distance] <=> y[:distance] }

        neighbors = distances.first(@k).map { |pair| pair[:value] }

        neighbors.sum / neighbors.length
      end

      private

      def euclidian_distance(vector1, vector2)
        Math.sqrt((vector1 - vector2).map { |v| (v.abs)**2 }.sum)
      end

    end
  end
end
