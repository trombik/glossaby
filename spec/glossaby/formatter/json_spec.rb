# frozen_string_literal: true

require "glossaby/formatter/json"

RSpec.describe Glossaby::Formatter::JSON do
  let(:glossary) do
    Glossaby::Result::ResultSet.new << Glossaby::Result::Base.new(
      name: "foo",
      count: 3,
      pos: "NOUN",
      context: "It is foo"
    )
  end

  let(:glossary_json) do
    [
      {
        name: "foo",
        count: 3,
        pos: "NOUN",
        contexts: ["It is foo"]
      }
    ].to_json
  end

  describe "#new" do
    it "does not throw" do
      expect { described_class.new(glossary) }.not_to raise_error
    end
  end

  describe "#format" do
    it "returns json" do
      result = JSON.parse(described_class.new(glossary).format)
      expected = JSON.parse(glossary_json)

      expect(result).to eq expected
    end
  end
end
