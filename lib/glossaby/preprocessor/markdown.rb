# frozen_string_literal: true

require "glossaby/preprocessor/base"
require "redcarpet"
require "redcarpet/render_strip"

module Glossaby
  module Preprocessor
    # Implements Makrdown Preprocessor
    class Markdown < Glossaby::Preprocessor::Base
      def process
        markdown = read
        Redcarpet::Markdown.new(Redcarpet::Render::StripDown).render(markdown)
      end
    end
  end
end
