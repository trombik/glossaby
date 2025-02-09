# frozen_string_literal: true

require "terminal-table"
require "glossaby/runner"
require "json"

module Glossaby
  # A class that implements extracting named entities with Named Entity
  # Recognition.
  class NER < Runner
    IGNORED_LABELS = %w[CARDINAL DATE].freeze

    def collect_keyword
      keyword = {}
      doc.ents.each do |ent|
        if keyword.key?(ent.text)
          keyword[ent.text][:count] += 1
        else
          next if IGNORED_LABELS.include? ent.label

          keyword[ent.text] = { type: "ner", count: 1, label: ent.label }
        end
      end
      keyword
    end

    def run
      collect_keyword
    end
  end
end
