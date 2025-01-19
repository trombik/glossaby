# frozen_string_literal: true

require "glossaby/preprocessor/base"
require "pdf-reader"

module Glossaby
  module Preprocessor
    # Implements PDF Preprocessor
    class PDF < Glossaby::Preprocessor::Base
      def read
        ::PDF::Reader.new(@file)
      end

      def pages
        read.pages
      end

      def process
        content_text = ""
        pages.each do |page|
          content_text += page.text
        end
        content_text
      end
    end
  end
end
