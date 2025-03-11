# frozen_string_literal: true

require "glossaby/runner"

module Glossaby
  # A class to extract noun phrases
  class PhraseFreq < Runner
    def singularize(token)
      token.pos == "NOUN" ? token.lemma_ : token.text
    end

    # remove articles, or DET
    def remove_articles(span)
      if span.first.pos == "DET"
        doc[span.start + 1..span.end]
      else
        span
      end
    end

    def single_word?(span)
      span.reject { |token| token.pos == "SPACE" }.length < 2
    end

    # reject articles, etc from the tokens
    def normalize_to_tokens(span)
      span.select { |token| %w[NOUN PROPN ADJ ADV VERB].include? token.pos }
    end

    # lower the cases and make all nouns singular
    def normalize_to_text(tokens)
      tokens.map { |token| singularize(token) }.join(" ").downcase
    end

    def normalize_span_to_text(span)
      tokens = normalize_to_tokens(span)
      normalize_to_text(tokens)
    end

    def collect_phrases
      noun_phrases = Glossaby::Result::ResultSet.new
      doc.noun_chunks.each do |span|
        span = remove_articles(span)

        # reject single word NP
        next if single_word?(span)

        text = normalize_span_to_text(span)
        noun_phrases << Glossaby::Result::Base.new(name: text, count: 1)
      end
      noun_phrases
    end

    def run
      collect_phrases
    end
  end
end
