require 'terminal-table'
require 'csv'

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

      def summary
        headings = ['Class','Precision','Recall']

        ::Terminal::Table.new(rows: summary_rows, headings: headings).to_s
      end

      def to_csv(file_path)
        headings = ['Class','Precision','Recall']

        CSV.open file_path, 'w' do |csv|
          csv << headings

          summary_rows.each do |row|
            csv << row
          end
        end
      end

      private

      def summary_rows
        rows = []
        precision_sum = 0
        recall_sum = 0

        @unique_classes.each do |cls|
          rows << [cls, self.precision(cls), self.recall(cls)]
          precision_sum = precision_sum + self.precision(cls)
          recall_sum = recall_sum + self.recall(cls)
        end

        rows << ['Overall Average', precision_sum / @unique_classes.length.to_f, recall_sum / @unique_classes.length.to_f]

        rows
      end

      def preprocess_classes
        @classes[:accurately_predicted] = @classes.map_rows { |r| r[:predicted] == r[:actual] }
      end

    end
  end
end