module Lurn
  module NaiveBayes
    class Base
      def predict_probabilities(vector)
        log_probabilties = predict_log_probabilities(vector)

        log_probabilties.map { |p| Math.exp(p) }
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

      def predict_log_probabilities(vector)
        vector = Vector.elements(vector)
        jll = joint_log_likelihood(vector)
        log_prob_x = Math.log(jll.map { |v| Math.exp(v) }.sum)
        jll.map{ |v| v - log_prob_x }
      end
    end
  end
end
