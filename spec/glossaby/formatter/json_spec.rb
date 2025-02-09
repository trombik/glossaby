# frozen_string_literal: true

require "glossaby/formatter/json"

RSpec.describe Glossaby::Formatter::JSON do
  let(:glossary) do
    {
      "foo" => {
        count: 3,
        type: "ner",
        label: "PERSON"
      }
    }
  end

  describe "#new" do
    it "does not throw" do
      expect { described_class.new(glossary) }.not_to raise_error
    end
  end

  describe "#format" do
    it "returns json" do
      expect(described_class.new(glossary).format).to eq glossary.to_json
    end
  end
end
