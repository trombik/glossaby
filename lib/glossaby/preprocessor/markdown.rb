# frozen_string_literal: true

require "glossaby/preprocessor/base"
require "redcarpet"
require "redcarpet/render_strip"

# A custom render to ignore code blocks
class StripDownWithoutCodeBlock < Redcarpet::Render::StripDown
  # it is rare for code blocks to contain meaningfully necessary terms and
  # the code pollutes glossary. ignore all the code blocks
  def block_code(_code, _language)
    nil
  end
end

module Glossaby
  module Preprocessor
    # Implements Makrdown Preprocessor
    class Markdown < Glossaby::Preprocessor::Base
      def process
        markdown = read
        Redcarpet::Markdown.new(StripDownWithoutCodeBlock, fenced_code_blocks: true).render(markdown)
      end
    end
  end
end
