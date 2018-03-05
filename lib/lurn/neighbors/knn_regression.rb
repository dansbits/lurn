module Lurn
  module Neighbors
    class KNNRegression

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

      # Predicts the value of the given observation by averaging the target value of the
      # closest k predictor observations based on euclidian distance.
      #
      # @param vector [Array-like]
      #   An array (or array-like) of the same length as the predictors used
      #   to fit the model
      # @return [Float] The predicted value
      def predict(vector)
        vector = Vector.elements(vector)

        distances = @predictors.map.with_index do |p, index|
          { distance: euclidian_distance(p, vector), value: targets[index] }
        end

        distances.sort! { |x,y| x[:distance] <=> y[:distance] }

        neighbors = distances.first(@k).map { |pair| pair[:value] }

        neighbors.sum.to_f / neighbors.length.to_f
      end

      private

      def euclidian_distance(vector1, vector2)
        Math.sqrt((vector1 - vector2).map { |v| (v.abs)**2 }.sum)
      end

    end
  end
end
