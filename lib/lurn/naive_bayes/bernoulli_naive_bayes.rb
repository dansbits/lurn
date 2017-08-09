require 'matrix'

module Lurn
  module NaiveBayes
    class BernoulliNaiveBayes

      attr_accessor :probability_matrix, :label_probbilities

      def initialize
        @labels = {}
        @word_stats = []
        @k = 1.0
      end

      def fit(vectors, labels)
        vectors = Matrix.rows(vectors)

        @unique_labels = labels.uniq
        @feature_count = vectors.column_size

        document_count_matrix = build_document_count_matrix(vectors, labels)
        @probability_matrix = build_probability_matrix(document_count_matrix, labels)

        @label_probbilities = @unique_labels.map { |l1| labels.select { |l2| l1 == l2 }.count.to_f / labels.count.to_f }
      end

      def predict(vector)
        probabilities = {}

        @unique_labels.each_with_index do |label, index|
          probabilities[label] = prob_label(vector, label)
        end

        probabilities
      end

      private

      def build_probability_matrix(document_count_matrix, labels)
        probability_matrix = Array.new(@unique_labels.count) { Array.new(@feature_count) { 0.0 } }

        document_count_matrix.each_with_index do |value, row, col|
          label = @unique_labels[row]
          label_frequency = labels.select { |l| l == label }.count

          probability_matrix[row][col] = (value.to_f + @k) / (label_frequency.to_f + (2.0 * @k))
        end

        Matrix.rows(probability_matrix)
      end

      def build_document_count_matrix(vectors, labels)
        matrix = Array.new(@unique_labels.count) { Array.new(@feature_count) { 0 } }

        vectors.each_with_index do |value, row, col|
          if value == true
            label = labels[row]
            label_index = @unique_labels.index(label)
            matrix[label_index][col] += 1
          end
        end

        Matrix.rows(matrix)
      end

      def prob_label(vector, label)
        label_index = @unique_labels.index(label)

        probabilities = @probability_matrix.row(label_index)

        score = Math.log(@label_probbilities[label_index])

        vector.each_with_index do |value, index|
          presence = value == true ? 1 : 0
          score = score * Math.log(((presence * probabilities[index]) + (1 - presence)*(1 - probabilities[index])))
        end

        Math.exp(score)
      end

    end
  end
end
