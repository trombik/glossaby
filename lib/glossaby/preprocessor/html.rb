# frozen_string_literal: true

require "glossaby/preprocessor/base"
require "nokogiri"

module Glossaby
  module Preprocessor
    # Implements HTML Preprocessor
    class HTML < Glossaby::Preprocessor::Base
      def process
        doc = Nokogiri::HTML(read)

        # it is rare for code blocks to contain meaningfully necessary terms and
        # the code pollutes glossary. ignore all the code blocks
        doc.at("code").remove
        doc.text.gsub(/\s+/, " ")
      end
    end
  end
end
