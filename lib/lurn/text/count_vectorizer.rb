module Lurn
  class CountVectorizer

    class UnexpectedType < RuntimeError; end

    attr_accessor :tokenized_docs
    attr_accessor :tokenizer
    attr_accessor :vocabulary

    def initialize(documents, options = {})

      @tokenizer = options[:tokenizer] || WordTokenizer.new

      if documents.class == Array
        documents = Daru::Vector.new(documents)
      elsif documents.class != Daru::Vector
        raise UnexpectedType.new "Expected Array or Daru::Vector but received #{documents.class.name}"
      end

      @options = options
      @tokenized_docs = tokenize_documents(documents)
      @vocabulary = @tokenized_docs.flatten.uniq.sort
    end

    def vectors
      vectorized_docs = @tokenized_docs.map do |doc|
        @vocabulary.map do |word|
          doc.select{ |w| w == word }.count
        end
      end

      vectorized_docs
    end

    private

    def tokenize_documents(documents)
      documents.map { |doc| @tokenizer.tokenize(doc) }
    end

  end
end
