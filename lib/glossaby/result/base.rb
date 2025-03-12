# frozen_string_literal: true

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
        @name = args[:name]
        @count = args[:count]
        @contexts = [] << args[:context]
        @pos = args[:pos] || nil
      end
    end
  end
end
