# frozen_string_literal: true

require "glossaby/formatter/csv"

RSpec.describe Glossaby::Formatter::CSV do
  let(:data) do
    {
      "foo" => {
        count: 3,
        type: "ner",
        label: "PERSON"
      }
    }
  end

  let(:csv) { "foo,\"\",3\n" }

  describe "#new" do
    it "does not throw" do
      expect { described_class.new(data) }.not_to raise_error
    end
  end

  describe "#format" do
    it "returns csv" do
      expect(described_class.new(data).format).to eq csv
    end
  end
end
