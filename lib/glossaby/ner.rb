# frozen_string_literal: true

require "terminal-table"
require "glossaby/runner"

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

          keyword[ent.text] = { count: 1, label: ent.label }
        end
      end
      keyword
    end

    def run
      rows = []
      headings = %w[text label count]
      keyword = collect_keyword
      keyword.keys.map do |k|
        v = keyword[k]
        rows << [k, v[:label], v[:count]]
      end
      table = Terminal::Table.new rows: rows.sort { |a, b| b[2] <=> a[2] }, headings: headings
      puts table
    end
  end
end
