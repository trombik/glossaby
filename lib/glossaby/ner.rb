# frozen_string_literal: true

require "terminal-table"
require "glossaby/runner"
require "glossaby/result/base"
require "glossaby/result/result_set"
require "json"

module Glossaby
  # A class that implements extracting named entities with Named Entity
  # Recognition.
  class NER < Runner
    IGNORED_LABELS = %w[CARDINAL DATE].freeze

    def collect_keyword
      keywords = Glossaby::Result::ResultSet.new
      doc.ents.each do |ent|
        next if IGNORED_LABELS.include? ent.label

        count = doc.tokens.map(&:lemma_).tally[ent.text]
        keywords << Glossaby::Result::Base.new(name: ent.text, count: count)
      end
      keywords
    end

    def run
      collect_keyword
    end
  end
end
