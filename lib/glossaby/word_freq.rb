# frozen_string_literal: true

require "glossaby/runner"

module Glossaby
  class WordFreq < Runner
    # see https://universaldependencies.org/u/pos/
    WHITE_LISTED_POS_TAGS = %w[
      ADJ
      ADV
      VERB
      NOUN
      PROPN
    ].freeze

    def unwanted?(token)
      # reject stop words
      return true if token.is_stop
      return true unless WHITE_LISTED_POS_TAGS.include? token.pos_

      # reject a single character text
      true if token.text.to_s.length <= 1
    end

    def collect_keywords
      keywords = Glossaby::Result::ResultSet.new
      doc.each do |token|
        next if unwanted?(token)

        element = Glossaby::Result::Base.new(
          name: token.lemma_, count: 1,
          context: token.sent.to_s, pos: token.pos
        )
        keywords << element
      end
      keywords
    end

    def run
      collect_keywords
    end
  end
end
