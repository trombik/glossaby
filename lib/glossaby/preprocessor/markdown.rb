# frozen_string_literal: true

require "redcarpet"
require "redcarpet/render_strip"
require "pathname"

module Glossaby
  module Preprocessor
    # Implements Makrdown Preprocessor
    class Markdown
      def initialize(file)
        @file = Pathname(file)
      end

      def read
        File.read(@file.realpath)
      end

      def process
        markdown = read
        Redcarpet::Markdown.new(Redcarpet::Render::StripDown).render(markdown)
      end
    end
  end
end
