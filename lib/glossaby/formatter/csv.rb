# frozen_string_literal: true

require "csv"

module Glossaby
  module Formatter
    # CSV formatter
    class CSV
      def initialize(data)
        @data = data
      end

      def format
        ::CSV.generate do |csv|
          @data.each do |element|
            csv << [element.count, element.name, element.contexts&.join("\n")]
          end
        end
      end
    end
  end
end
