require 'lingua/stemmer'

module Lurn
  module Text
    class WordTokenizer

      attr_accessor :options

      STOP_WORDS = %w[
        a about above after again against all am an and any are aren't as at be
        because been before being below between both but by can't cannot could
        couldn't did didn't do does doesn't doing don't down during each few for
        from further had hadn't has hasn't have haven't having he he'd he'll
        he's her here here's hers herself him himself his how how's i i'd i'll
        i'm i've if in into is isn't it it's its itself let's me more most
        mustn't my myself no nor not of off on once only or other ought our ours
      ]

      def initialize(options = {})
        @options = options
        @options[:strip_punctuation] ||= false
        @options[:strip_stopwords] ||= false
        @options[:stem_words] ||= false
      end

      def tokenize(document)
        document = document.gsub(/[[:punct:]]/, '') if @options[:strip_punctuation] == true
        document = document.gsub(/\s+/, ' ').split(" ")

        if(@options[:stem_words])
          stemmer = Lingua::Stemmer.new(language: :en)
          document = document.map { |word| stemmer.stem(word) }
        end

        document
      end

      def to_h
        options
      end
    end
  end
end
