# frozen_string_literal: true

module Glossaby
  module Result
    # A class that represents a term found in a document.
    class Base
      # @return [String] The term
      attr_accessor :name

      # @return [Integer] The frequency in documents
      attr_accessor :freq

      # @return [Array<String>] The frequency in documents
      attr_accessor :contexts

      alias term name

      # The constructor.
      #
      # @param args [Hash] keyword arguments for person attributes
      # @option args [String] :name The term.
      # @option args [Integer] :freq The frequency
      # @option args [String] :context The context in which the term appeared
      #
      # @example Example usage:
      #   obj = Glossaby::Result::Base.new(name: "foo", freq: 1, context: "This is foo")
      def initialize(**args)
        @name = args[:name]
        @freq = args[:freq]
        @contexts = [] << args[:context]
      end
    end
  end
end
