module Lurn
  module NaiveBayes
    class MultinomialNaiveBayes < Base

      attr_accessor :prior_probabilities, :probability_matrix, :unique_labels

      def initialize

      end

      def fit(vectors, labels)
        vectors = Matrix.rows(vectors)

        @unique_labels = labels.uniq
        @feature_count = vectors.column_size
        count_matrix = build_count_matrix(vectors, labels)
        @probability_matrix = build_probability_matrix(count_matrix, labels)
        @prior_probabilities = @unique_labels.map do |l1|
          labels.count { |l2| l1 == l2 }.to_f / labels.count.to_f
        end
      end

      private

      def build_probability_matrix(count_matrix, labels)
        probability_matrix = Array.new(@unique_labels.count) { Array.new(@feature_count, 0.0) }

        count_matrix.each_with_index do |value, row, col|
          label = @unique_labels[row]
          label_frequency = labels.count(label)

          numerator = (value.to_f + 1.0)
          denominator = count_matrix.row(row).inject(:+) + @feature_count
          probability_matrix[row][col] = Math.log(numerator / denominator)
        end

        probability_matrix
      end

      def build_count_matrix(vectors, labels)
        matrix = Array.new(@unique_labels.count) { Array.new(@feature_count, 0) }

        vectors.each_with_index do |value, row, col|
          label = labels[row]
          label_index = @unique_labels.index(label)
          matrix[label_index][col] += value
        end

        Matrix.rows(matrix)
      end

      def joint_log_likelihood(vector)
        jlls = []
        @unique_labels.each_with_index do |label, label_index|
          probabilities = @probability_matrix[label_index]
          jll = vector.dot(probabilities)
          jll += Math.log(@prior_probabilities[label_index])
          jlls.push(jll)
        end

        jlls
      end
    end
  end
end
