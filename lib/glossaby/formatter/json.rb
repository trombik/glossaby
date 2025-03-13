# frozen_string_literal: true

require "json"

module Glossaby
  module Formatter
    # JSON formatter
    class JSON
      def initialize(data)
        @data = data
      end

      def format
        @data.map(&:to_hash).to_json
      end
    end
  end
end
