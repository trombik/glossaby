# frozen_string_literal: true

require "glossaby/formatter/csv"

RSpec.describe Glossaby::Formatter::CSV do
  let(:data) do
    Glossaby::Result::ResultSet.new <<
      Glossaby::Result::Base.new(
        name: "foo",
        count: 3,
        context: "It is foo",
        pos: "NOUN"
      )
  end

  let(:csv) { "3,foo,It is foo\n" }

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
