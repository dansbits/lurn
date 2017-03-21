module Lurn
  module Evaluation
    class ClassifierEvaluator

      attr_accessor :unique_classes

      def initialize(predicted, actual)
        @classes = Daru::DataFrame.new(predicted: predicted, actual: actual)
        @unique_classes = (predicted + actual).uniq
        preprocess_classes
      end

      def precision(cls)
        true_positives = true_positives(cls)
        false_positives = false_positives(cls)
        true_positives.to_f / (true_positives + false_positives).to_f
      end

      def recall(cls)
        true_positives = true_positives(cls)
        false_nevatives = false_negatives(cls)

        true_positives.to_f / (true_positives + false_nevatives).to_f
      end

      def true_positives(cls)
        @classes.filter_rows { |r| r[:predicted] == r[:actual] && r[:predicted] == cls }.size
      end

      def false_positives(cls)
        @classes.filter_rows { |r| r[:predicted] == cls && r[:actual] != cls }.size
      end

      def false_negatives(cls)
        @classes.filter_rows { |r| r[:actual] == cls && r[:predicted] != cls }.size
      end

      private

      def preprocess_classes
        @classes[:accurately_predicted] = @classes.map_rows { |r| r[:predicted] == r[:actual] }
      end

    end
  end
end