module Lurn
  module NaiveBayes
    class MultinomialNaiveBayes

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

      def predict_probabilities(vector)
        log_probabilties = predict_log_probabilities(vector)

        log_probabilties.map { |p| Math.exp(p) }
      end

      def predict_log_probabilities(vector)
        vector = Vector.elements(vector)
        jll = joint_log_likelihood(vector)

        log_prob_x = Math.log(jll.map { |v| Math.exp(v) }.sum)
        jll.map{ |v| v - log_prob_x }
      end

      def max_class(vector)
        log_probs = predict_log_probabilities(vector)

        max_index = log_probs.index(log_probs.max)

        unique_labels[max_index]
      end

      def max_probability(vector)
        probs = predict_probabilities(vector)

        probs.max
      end

      private

      def build_probability_matrix(count_matrix, labels)
        probability_matrix = Array.new(@unique_labels.count) { Array.new(@feature_count, 0.0) }

        count_matrix.each_with_index do |value, row, col|
          label = @unique_labels[row]
          label_frequency = labels.count(label)

          numerator = (value.to_f + 1.0)
          denominator = count_matrix.row(row).sum + @feature_count
          probability_matrix[row][col] = Math.log(numerator / denominator)
        end

        Matrix.rows(probability_matrix)
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
          probabilities = @probability_matrix.row(label_index)
          jll = vector.dot(probabilities)
          jll += Math.log(@prior_probabilities[label_index])
          jlls.push(jll)
        end

        jlls
      end
    end
  end
end
