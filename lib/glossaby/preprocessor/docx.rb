# frozen_string_literal: true

require "glossaby/preprocessor/base"
require "docx"

module Glossaby
  module Preprocessor
    # Implements Word Preprocessor.
    class Docx < Glossaby::Preprocessor::Base
      def process
        doc = ::Docx::Document.open(File.open(@file))
        doc.paragraphs.join(" ").gsub(/\s+/, " ")
      end
    end
  end
end
