module Lurn
  module Text
    class WordCountVectorizer

      attr_accessor :tokenizer
      attr_accessor :vocabulary

      def initialize(options = {})
        @tokenizer = options[:tokenizer] || WordTokenizer.new
        @vocabulary = []

        options[:max_df] ||= 50
        options[:min_df] ||= 0
        @options = options
      end

      def fit(documents)
        @vocabulary = []
        tokenized_docs = tokenize_documents(documents)
        @vocabulary = tokenized_docs.flatten(1).uniq.sort
        reduce_features(tokenized_docs)
      end

      def to_h
        {
          tokenizer_options: @tokenizer.to_h,
          vocabulary: @vocabulary
        }
      end

      def transform(documents)
        documents.map do |document|
          tokens = @tokenizer.tokenize(document)
          @vocabulary.map do |word|
            tokens.count word
          end
        end
      end

      private

      def reduce_features(tokenized_docs)
        doc_frequencies = Array.new(@vocabulary.length, 0)

        tokenized_docs.each do |tokens|
          tokens.each do |token|
            vocab_index = @vocabulary.index(token)
            doc_frequencies[vocab_index] += 1
          end
        end

        reduced_features = @vocabulary.select.with_index do |token, index|
          freq = doc_frequencies[index]
          @options[:min_df] < freq && freq < @options[:max_df]
        end

        @vocabulary = reduced_features
      end

      def tokenize_documents(documents)
        documents.map { |doc| @tokenizer.tokenize(doc).uniq }
      end
    end
  end
end
