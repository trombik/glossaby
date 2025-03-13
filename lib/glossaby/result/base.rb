# frozen_string_literal: true

require "json"

module Glossaby
  module Result
    # A class that represents a term found in a document.
    class Base
      # @return [String] The term
      attr_accessor :name

      # @return [Integer] The occurance of the term in documents
      attr_accessor :count

      # @return [Array<String>] The frequency in documents
      attr_accessor :contexts

      # @return [String] One of POS tags. See https://universaldependencies.org/u/pos/
      attr_accessor :pos

      alias term name

      # The constructor.
      #
      # @param args [Hash] keyword arguments for person attributes
      # @option args [String] :name The term.
      # @option args [Integer] :count The occurance
      # @option args [String] :context The context in which the term appeared
      # @option args [String] :pos Onr of POS tags.
      #
      # @example Example usage:
      #   obj = Glossaby::Result::Base.new(name: "foo", count: 1, context: "This is foo")
      def initialize(**args)
        raise ArgumentError, ":name is required" if args[:name].nil?

        @name = args[:name]
        @count = args[:count] || 1
        @contexts = [] << normalize_text(args[:context]) unless args[:context].nil?
        @pos = args[:pos] || nil
      end

      # Returns a hash representation of the object.
      # @return [Hash] The hash of the object
      def to_hash
        hash = {}
        instance_variables.each { |var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
        hash
      end

      # Returns a JSON representation of the object.
      # @return [String] The JSON of the object
      def to_json(*args)
        to_hash.to_json(*args)
      end

      private

      def normalize_text(text)
        text = replace_line_breaks(text)
        replace_spaces(text)
      end

      def replace_line_breaks(text)
        text.gsub("\n", " ")
      end

      def replace_spaces(text)
        text.gsub(/\s+/, " ")
      end
    end
  end
end
