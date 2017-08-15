require 'matrix'

module Lurn
  module NaiveBayes
    class BernoulliNaiveBayes

      attr_accessor :probability_matrix, :label_probabilities

      def initialize
        @k = 1.0
      end

      def fit(vectors, labels)
        vectors = Matrix.rows(vectors)

        @unique_labels = labels.uniq
        @feature_count = vectors.column_size

        document_count_matrix = build_document_count_matrix(vectors, labels)
        @probability_matrix = build_probability_matrix(document_count_matrix, labels)

        @label_probabilities = @unique_labels.map { |l1| labels.select { |l2| l1 == l2 }.count.to_f / labels.count.to_f }
      end

      def predict_probabilities(vector)
        log_probabilties = predict_log_probabilities(vector)

        log_probabilties.map { |p| Math.exp(p) }
      end

      def predict_log_probabilities(vector)

        probabilities = @unique_labels.map do |label|
          joint_log_likelihood(vector, label)
        end

        log_prob_x = Math.log(probabilities.map { |v| Math.exp(v) }.sum)

        probabilities.map { |p| p - log_prob_x }
      end

      private

      def build_probability_matrix(document_count_matrix, labels)
        probability_matrix = Array.new(@unique_labels.count) { Array.new(@feature_count) { 0.0 } }

        document_count_matrix.each_with_index do |value, row, col|
          label = @unique_labels[row]
          label_frequency = labels.select { |l| l == label }.count

          probability_matrix[row][col] = Math.log((value.to_f + @k) / (label_frequency.to_f + (2.0 * @k)))
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

      def joint_log_likelihood(vector, label)
        label_index = @unique_labels.index(label)

        vector = Vector.elements(vector.map { |e| e == true ? 1 : 0 })
        probabilities = @probability_matrix.row(label_index)
        neg_probs = probabilities.map { |prb| Math.log(1.0 - Math.exp(prb)) }
        jll = vector.dot(probabilities - neg_probs)
        jll += Math.log(@label_probabilities[label_index]) + neg_probs.sum

        jll
      end

    end
  end
end
