module Lurn
  module Text
    class WordTokenizer

      def initialize(options = {})
        @options = options
        @options[:strip_punctuation] ||= false
      end

      def tokenize(document)
        document = document.gsub(/[[:punct:]]/, '') if @options[:strip_punctuation] == true
        document.gsub(/\s+/, ' ').split(" ")
      end
    end
  end
end
