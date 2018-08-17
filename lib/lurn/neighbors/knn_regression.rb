module Lurn
  module Neighbors
    class KNNRegression < KNNBase

      # Predicts the value of the given observation by averaging the target value of the
      # closest k predictor observations based on euclidian distance.
      #
      # @param vector [Array-like]
      #   An array (or array-like) of the same length as the predictors used
      #   to fit the model
      # @return [Float] The predicted value
      def predict(vector)
        _, neighboring_targets = nearest_neighbors(vector)

        neighboring_targets.inject(:+).to_f / neighboring_targets.length.to_f
      end

    end
  end
end
