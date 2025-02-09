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
          @data.each_key
               .map { |key| [key, "", @data[key][:count]] }
               .sort { |a, b| b[2] <=> a[2] }
               .each do |row|
            csv << row
          end
        end
      end
    end
  end
end
