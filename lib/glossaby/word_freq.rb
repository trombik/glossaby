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
    ]

    def collect_keywords
      keywords = []
      doc.each do |token|

        # reject stop words
        next if token.is_stop
        next unless WHITE_LISTED_POS_TAGS.include? token.pos_

        # reject a single character text
        next if token.text.to_s.length <= 1

        lemma = token.lemma_
        pos = token.pos_
        sentence = token.sent.to_s
        keyword = keywords.select { |keyword| keyword[:lemma] == lemma && keyword[:pos] == pos }.first
        if keyword
          keyword[:freq] += 1
          keyword[:sentence] << sentence
        else
          keywords << {
            lemma: lemma,
            pos: pos,
            freq: 1,
            sentence: [sentence]
          }
        end
      end
      keywords.select { |k| k[:freq] > 1 }
    end

    def run
      collect_keywords
    end
  end
end
