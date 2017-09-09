module Lurn
  module Text
    class BernoulliVectorizer

      attr_accessor :tokenizer
      attr_accessor :vocabulary

      def initialize(options = {})
        @tokenizer = options[:tokenizer] || WordTokenizer.new
        @vocabulary = []

        @options = options
      end

      def fit(documents)
        @vocabulary = []
        tokenized_docs = tokenize_documents(documents)
        @vocabulary = tokenized_docs.flatten.uniq.sort
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
            tokens.include? word
          end
        end
      end

      private

      def tokenize_documents(documents)
        documents.map { |doc| @tokenizer.tokenize(doc) }
      end
    end
  end
end
