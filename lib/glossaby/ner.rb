# frozen_string_literal: true

require "glossaby"
require "ruby-spacy"
require "terminal-table"
require "pathname"
require "glossaby/preprocessor/markdown"

module Glossaby
  # A class that implements extracting named entities with Named Entity
  # Recognition.
  class NER
    IGNORED_LABELS = %w[CARDINAL DATE].freeze

    def initialize(opts)
      @file = Pathname opts[:args].first
    end

    def nlp
      return @nlp if @nlp

      @nlp = Spacy::Language.new("en_core_web_sm")
    end

    def preprocessor
      return @preprocessor if @preprocessor

      @preprocessor = case @file.extname
                      when ".md"
                        Glossaby::Preprocessor::Markdown.new(@file)
                      end
    end

    def doc
      return @doc if @doc

      @doc = nlp.read(preprocessor.process)
    end

    def run
      rows = []
      keyword = {}
      doc.ents.each do |ent|
        if keyword.key?(ent.text)
          keyword[ent.text][:count] += 1
        else
          next if IGNORED_LABELS.include? ent.label

          keyword[ent.text] = {
            count: 1,
            label: ent.label
          }
        end
      end

      headings = %w[text label count]
      keyword.keys.map do |k|
        v = keyword[k]
        rows << [k, v[:label], v[:count]]
      end
      table = Terminal::Table.new rows: rows.sort { |a, b| b[2] <=> a[2] }, headings: headings
      puts table
    end
  end
end
