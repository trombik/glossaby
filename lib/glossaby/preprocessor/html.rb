# frozen_string_literal: true

require "glossaby/preprocessor/base"
require "nokogiri"

module Glossaby
  module Preprocessor
    # Implements HTML Preprocessor
    class HTML < Glossaby::Preprocessor::Base
      def process
        doc = Nokogiri::HTML(read)
        doc = doc.at_css(opts[:css] || "body")

        # it is rare for code blocks to contain meaningfully necessary terms and
        # the code pollutes glossary. ignore all the code blocks
        doc.css("code").remove
        doc.css("pre").remove
        doc.text.gsub(/\s+/, " ")
      end
    end
  end
end
