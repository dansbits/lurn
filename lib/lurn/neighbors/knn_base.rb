module Lurn
  module Neighbors
    class KNNBase

      attr_accessor :predictors, :targets, :k

      def initialize(k)
        @k = k
      end

      # Trains the KNN regression model to predict the target variable
      # based on the predictors. For KNN Regression all computation is
      # deferred until the time of prediction so in this case the data
      # is just stored.
      #
      # @param predictors [Array-like] An array of arrays containing the predictor data
      # @param targets [Array-like] An array with the value you want to predict
      def fit(predictors, targets)
        @predictors = predictors.map { |pred| Vector.elements(pred) }
        @targets = targets

        nil
      end

      # Returns the predictors and target value for the k nearest neighbors for the vector parameter
      #
      # @param vector [Array-like] An array of the same length and type as the predictors used to train the model
      # @return [Array, Array]
      #   Returns two values. The first is an array of the predictors for the k nearest neighbors. The second is an
      #   array of the corresponding target values for the k nearest neighbors.
      def nearest_neighbors(vector)
        vector = Vector.elements(vector)

        distances = @predictors.map.with_index do |p, index|
          { index: index, distance: euclidian_distance(p, vector), value: targets[index] }
        end

        distances.sort! { |x,y| x[:distance] <=> y[:distance] }

        neighboring_predictors = distances.first(@k).map { |neighbor| @predictors[neighbor[:index]] }
        neighboring_targets = distances.first(@k).map { |neighbor| @targets[neighbor[:index]] }

        return neighboring_predictors, neighboring_targets
      end

      private

      def euclidian_distance(vector1, vector2)
        Math.sqrt((vector1 - vector2).map { |v| (v.abs)**2 }.sum)
      end

    end
  end
end
