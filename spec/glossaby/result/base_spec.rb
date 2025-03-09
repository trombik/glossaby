# frozen_string_literal: true

require "glossaby/result/base"

RSpec.describe Glossaby::Result::Base do
  subject(:base_result) do
    described_class.new(
      name: "foo",
      freq: 2,
      context: context
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

    it "accepts freq as an argument" do
      expect(base_result.freq).to eq 2
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
end
