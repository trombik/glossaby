# frozen_string_literal: true

require "pathname"

module Glossaby
  module Preprocessor
    # the base class for Glossaby::Preprocessor
    class Base
      def initialize(file, opts)
        @file = Pathname(file)
        @opts = opts
      end

      attr_reader :opts

      def read
        File.read(@file.realpath)
      end

      def process
        raise "method process not implemented: #{self} must implemente `process` method"
      end
    end
  end
end
