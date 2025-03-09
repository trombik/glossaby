# frozen_string_literal: true

require "pathname"
require "glossaby"
require "ruby-spacy"
require "glossaby/preprocessor/markdown"
require "glossaby/preprocessor/pdf"
require "glossaby/preprocessor/html"

module Glossaby
  # A base runner class for sub commands
  class Runner
    def initialize(opts)
      @file = Pathname opts[:args].first
      @opts = opts[:options]
    end

    def nlp
      return @nlp if @nlp

      @nlp = Spacy::Language.new("en_core_web_sm")

      # XXX increase max_length to process a long text
      @nlp.max_length = 1_000_000 * 2
      @nlp
    end

    def preprocessor
      return @preprocessor if @preprocessor

      @preprocessor = case @file.extname
                      when ".md"
                        Glossaby::Preprocessor::Markdown.new(@file, @opts)
                      when ".pdf"
                        Glossaby::Preprocessor::PDF.new(@file, @opts)
                      when ".html", ".htm"
                        {
                          css: @opts.filter_html_css
                        }
                        Glossaby::Preprocessor::HTML.new(@file, @opts)
                      end
    end

    def doc
      return @doc if @doc

      @doc = nlp.read(preprocessor.process)
    end

    def run
      raise "bug: #{self.class} does not implement `run` method"
    end
  end
end
