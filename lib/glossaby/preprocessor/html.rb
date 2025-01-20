# frozen_string_literal: true

require "glossaby/preprocessor/base"
require "nokogiri"

module Glossaby
  module Preprocessor
    # Implements HTML Preprocessor
    class HTML < Glossaby::Preprocessor::Base
      def process
        Nokogiri::HTML(read).text.gsub(/\s+/, " ")
      end
    end
  end
end
