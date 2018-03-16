module Lurn
  module Neighbors
    class KNNClassifier < KNNBase

      # Predicts the class of the given observation by selecting the most common class of the
      # closest k training observations based on euclidian distance. In the case of a tie one winner
      # will be chosen at random from the most frequent classes.
      #
      # @param vector [Array-like]
      #   An array (or array-like) of the same length as the predictors used
      #   to fit the model
      # @return [Object] The predicted class
      def predict(vector)
        _, neighboring_targets = nearest_neighbors(vector)

        class_frequencies = neighboring_targets.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

        neighboring_targets.max_by { |v| class_frequencies[v] }
      end

    end
  end
end
