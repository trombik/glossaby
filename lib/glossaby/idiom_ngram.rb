# frozen_string_literal: true

module Glossaby
  # A class that produces a glossay based on N-gram.
  #
  # The class finds possible idioms by creating an array of N-grams from the
  # document and counts occurance of each N-gram.
  class IdiomNgram < Runner
    def run
      ngrams
    end

    # Creates an Glossaby::Result::ResultSet of N-grams.
    #
    # @param [Integer] size The size of N-gram. The default is 3.
    # @return [Array<string>] Array of N-grams
    def ngrams(size = 3)
      reult_set = Glossaby::Result::ResultSet.new
      last_index = -(size - 1)
      normalized_tokens[0..last_index].each_index do |index|
        tokens = doc[index..(index + (size - 1))]
        result = ngramified_result(tokens)
        next if result.nil?

        reult_set << result
      end
      reult_set
    end

    private

    def ngramified_result(tokens)
      return nil if include_punct?(tokens)

      Glossaby::Result::Base.new(
        name: tokens.map(&:lemma).join(" "),
        context: tokens.first.sent.to_s
      )
    end

    def normalized_tokens
      doc.reject { |token| token.lemma =~ /^\s+$/ }
    end

    def include_punct?(tokens)
      tokens.each do |token|
        return true if token.is_punct
      end
      false
    end
  end
end
