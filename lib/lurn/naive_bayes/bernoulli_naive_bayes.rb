module Lurn
  module NaiveBayes
    class BernoulliNaiveBayes

      attr_accessor :labels
      attr_accessor :word_stats

      def initialize
        @labels = {}
        @word_stats = []
        @k = 1.0
      end

      def fit(vectors, labels)
        @observation_count = vectors.length
        @feature_count = vectors[0].length

        # [ "I like cars", "I dont like cars"]
        labels.inject(@labels) do |memo, label|
          memo[label] ||= { observation_count: 0 }
          memo[label][:observation_count] += 1
          memo
        end

        @labels.keys.each { |label| fit_label(label, vectors, labels) }
      end

      def predict(vector)
        probabilities = {}

        @labels.keys.each do |label|
          probabilities[label] = prob_label(vector, label)
        end

        probabilities
      end

      private

      def prob_label(vector, label)
        word_probabilities = @labels[label][:word_probabilities]

        log_prob_if_label = 0.0
        log_prob_if_not_label = 0.0

        word_probabilities.each.with_index do |prob_pair, index|
          if vector[index] == true
            log_prob_if_label += Math.log(prob_pair[:prob_label])
            log_prob_if_not_label += Math.log(prob_pair[:prob_not_label])
          else
            log_prob_if_label += Math.log(1.0 - prob_pair[:prob_label])
            log_prob_if_not_label += Math.log(1.0 - prob_pair[:prob_not_label])
          end
        end

        prob_if_label = Math.exp(log_prob_if_label)
        prob_if_not_label = Math.exp(log_prob_if_not_label)

        prob_if_label / (prob_if_label + prob_if_not_label)
      end

      def fit_label(label, vectors, labels)
        @labels[label][:word_counts] = Array.new(@feature_count) { { predictor: 0, not_predictor: 0 } }
        @labels[label][:word_probabilities] = Array.new(@feature_count) { { prob_label: 0, prob_not_label: 0 } }

        # get word counts
        vectors.each.with_index do |vector, index|
          vector_label = labels[index]

          vector.each.with_index do |feature, feature_index|
            if feature
              if vector_label == label
                @labels[label][:word_counts][feature_index][:predictor] += 1
              else
                @labels[label][:word_counts][feature_index][:not_predictor] += 1
              end
            end
          end
        end

        # get word probabilities
        @labels[label][:word_counts].each.with_index do |count_pair, feature_index|
          prob_label = (count_pair[:predictor] + @k) / (@labels[label][:observation_count] + @k * 2)
          @labels[label][:word_probabilities][feature_index][:prob_label] = prob_label

          prob_not_label = (count_pair[:not_predictor] + @k) / ((@observation_count - @labels[label][:observation_count]) + @k * 2.0)
          @labels[label][:word_probabilities][feature_index][:prob_not_label] = prob_not_label
        end
      end

    end
  end
end
