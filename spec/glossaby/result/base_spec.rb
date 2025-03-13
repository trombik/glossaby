# frozen_string_literal: true

require "glossaby/result/base"
require "json"

RSpec.describe Glossaby::Result::Base do
  subject(:base_result) do
    described_class.new(
      name: "foo",
      count: 2,
      context: context
    )
  end

  let(:result_with_pos_tag) do
    described_class.new(
      name: "foo",
      conunt: 1,
      pos: "NOUN"
    )
  end

  let(:context) { "This is foo" }
  let(:another_context) { "In another context, it is foo" }

  describe "#new" do
    it "accepts anguments" do
      expect { base_result }.not_to raise_error
    end

    it "accepts name as a argument" do
      result = described_class.new(name: "foo")
      expect(result.name).to eq "foo"
    end

    it "accepts count as an argument" do
      expect(base_result.count).to eq 2
    end

    it "accepts pos as an argument" do
      expect(result_with_pos_tag.pos).to eq "NOUN"
    end
  end

  describe "#contexts" do
    it "returns an Array" do
      expect(base_result.contexts.class).to be Array
    end

    it "adds another context" do
      expect(base_result.contexts << another_context).to eq [context, another_context]
    end

    it "has two elements after adding another context" do
      base_result.contexts << another_context
      expect(base_result.contexts.length).to eq 2
    end
  end

  describe "#hash" do
    let(:hash) { base_result.to_hash }

    it "returns a Hash with correct attributes" do
      expect(hash.keys.sort).to eq %w[name count contexts pos].sort
    end

    it "returns a Hash with correct attribute values" do
      expect(hash["name"]).to eq "foo"
    end
  end

  describe "#to_json" do
    let(:json) { base_result.to_json }

    it "returns a valid JSON" do
      expect { JSON.parse(json) }.not_to raise_error
    end
  end
end
