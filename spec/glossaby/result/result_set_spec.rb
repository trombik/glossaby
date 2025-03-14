# frozen_string_literal: true

require "glossaby/result/result_set"
require "glossaby/result/base"

RSpec.describe Glossaby::Result::ResultSet do
  subject(:result_set_default) do
    result_set = described_class.new
    result_set << result_foo << result_bar
    result_set
  end

  let(:result_set_another) do
    result_set = described_class.new
    result_set << result_foo << result_bar << result_buz
    result_set
  end

  let(:result_foo) do
    Glossaby::Result::Base.new(
      name: "foo",
      count: 1,
      context: "This is foo"
    )
  end

  let(:result_bar) do
    Glossaby::Result::Base.new(
      name: "bar",
      count: 42,
      context: "It is bar"
    )
  end

  let(:result_buz) do
    Glossaby::Result::Base.new(
      name: "buz",
      count: 5,
      context: "It is buz"
    )
  end

  let(:result_with_pos) do
    Glossaby::Result::Base.new(
      name: "foo",
      conunt: 1,
      context: "With pos tag",
      pos: "NOUN"
    )
  end

  describe "#new" do
    it "does not raise error" do
      expect { described_class.new }.not_to raise_error
    end
  end

  describe "#find_by_name" do
    context "when given an existing element" do
      it "selects an element by name and returns the index of it" do
        index = result_set_default.find_by_name(result_foo.name)
        expect(result_set_default[index].name).to eq result_foo.name
      end
    end

    context "when given a non-existing element" do
      it "returns nil" do
        expect(result_set_default.find_by_name("buz")).to be_nil
      end
    end
  end

  describe "#include?" do
    context "when given a duplicated result" do
      it "returns true" do
        expect(result_set_default.include?(result_foo)).to be true
      end
    end

    context "when given a non-duplicated result" do
      it "returns false" do
        expect(result_set_default.include?(result_buz)).to be false
      end
    end
  end

  describe "#<<" do
    it "adds an element" do
      result_set = described_class.new << result_foo
      expect(result_set.length).to eq 1
    end

    context "when given a duplicated term as an argument" do
      it "does not change the length of the set" do
        result_set_default << result_foo
        expect(result_set_default.length).to eq 2
      end

      it "increments the term's count by one" do
        result_set_default << result_foo
        index = result_set_default.find_by_name(result_foo.name)
        expect(result_set_default[index].count).to eq 2
      end

      it "adds new context to the term and the number of contexts is correct" do
        result_set_default << result_foo
        index = result_set_default.find_by_name(result_foo.name)
        expect(result_set_default[index].contexts.length).to eq 2
      end

      it "adds new context to the term and the order of the contexts is correct" do
        result_set_default << result_foo
        index = result_set_default.find_by_name(result_foo.name)
        expect(result_set_default[index].contexts.last).to eq result_foo.contexts.first
      end
    end

    context "when given a new term as an argument" do
      it "increments its length by one" do
        result_set_default << result_buz
        expect(result_set_default.length).to eq 3
      end
    end

    context "when given a result with pos tag" do
      it "has two `foo` results" do
        result_set_default << result_with_pos
        result = result_set_default.select { |element| element.name == "foo" }
        expect(result.length).to eq 2
      end
    end
  end

  describe "#sort_by_count" do
    it "sorts by count in descending order" do
      expect(result_set_default.sort_by_count.map(&:count)).to eq [42, 1]
    end
  end

  describe "#sort_by_name" do
    it "sorts by name in ascending order" do
      expect(result_set_default.sort_by_name.map(&:name)).to eq [result_bar.name, result_foo.name]
    end
  end

  describe "#merge" do
    it "merges two result sets and each count is incremented" do
      expected_result = [result_foo.count + 1, result_bar.count + 1]
      merged = result_set_default.merge(result_set_another)
      result = [
        merged[merged.find_by_name(result_foo.name)].count,
        merged[merged.find_by_name(result_bar.name)].count
      ]
      expect(result).to eq expected_result
    end

    it "merges two result sets and each context is added" do
      merged = result_set_default.merge(result_set_another)
      index1 = merged.find_by_name(result_foo.name)
      index2 = merged.find_by_name(result_bar.name)
      result = [merged[index1].contexts.length, merged[index2].contexts.length]
      expect(result).to eq [2, 2]
    end
  end
end

RSpec.describe Glossaby::Result::ResultSet do
  describe "#sort_by_count_and_name" do
    let(:abc) do
      Glossaby::Result::Base.new(
        name: "abc",
        count: 2
      )
    end

    let(:bcd) do
      Glossaby::Result::Base.new(
        name: "bcd",
        count: 2
      )
    end

    let(:cde) do
      Glossaby::Result::Base.new(
        name: "cde",
        count: 5
      )
    end

    it "sorts by count and name" do
      result_set_for_sort = described_class.new
      result_set_for_sort << abc << bcd << cde
      result = result_set_for_sort.sort_by_count_and_name.map(&:name)
      expect(result).to eq %w[cde abc bcd]
    end
  end
end
