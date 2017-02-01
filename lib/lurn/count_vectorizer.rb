module Lurn
  class CountVectorizer

    class UnexpectedType < RuntimeError; end

    attr_accessor :tokenized_docs
    attr_accessor :tokenizer

    def initialize(documents, options = {})

      @tokenizer = options[:tokenizer] || WordTokenizer.new

      if documents.class == Array
        documents = Daru::Vector.new(documents)
      elsif documents.class != Daru::Vector
        raise UnexpectedType.new "Expected Array or Daru::Vector but received #{documents.class.name}"
      end

      @options = options
      @tokenized_docs = tokenize_documents(documents)
    end

    def vectors
      base = Hash[unique_words.zip([[]] * unique_words.count)]

      base.keys.each do |word|
        base[word] = @tokenized_docs.map { |doc| doc.select { |doc_word| doc_word == word }.count }
      end

      Daru::DataFrame.new(base)
    end

    private

    def unique_words
      @unique_words ||= @tokenized_docs.flatten.uniq
    end

    def tokenize_documents(documents)
      documents.map { |doc| @tokenizer.tokenize(doc) }
    end

  end
end
