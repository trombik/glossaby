# frozen_string_literal: true

module Glossaby
  module Result
    # A class representing Array of Glossaby::Result objects.
    #
    # The class bahaves like an Array with extra methods.
    #
    # @example Basic usage
    #
    # Glossaby::Result::ResultSet.new << Glossaby::Result::Base.new
    #
    class ResultSet < Array
      # Appends an object to Glossaby::Result::ResultSet. If the object is a
      # duplicate of another identical term with different contexts, The
      # freaqency of the other object is incremented by one and the context of
      # the argument is appended to the other term.
      #
      # @param element [Glossaby::Result::Base] An object to append to.
      #
      def <<(element)
        index = find_by_name(element.name)
        if index
          self[index].count += 1
          self[index].contexts += element.contexts if element.contexts
        else
          super
        end
        self
      end

      # Merges two Glossaby::Result::ResultSet.
      #
      # @param other [Glossaby::Result::ResultSet] The other [Glossaby::Result::ResultSet]
      # to merge.
      def merge(other)
        other.each do |element|
          self << element
        end
        self
      end

      # Find the index of a term that matches name.
      #
      # @param name [String] The string to find in the [Glossaby::Result::ResultSet].
      # @return [Integer] The index of the found term. If the term is not
      # found, returns nil.
      #
      def find_by_name(name)
        each_index do |index|
          return index if self[index].name == name
        end
        nil
      end

      def include?(element)
        !find_by_name(element.name).nil?
      end

      def sort_by_count
        sort { |a, b| b.count <=> a.count }
      end

      def sort_by_name
        sort { |a, b| a.name <=> b.name }
      end
    end
  end
end
