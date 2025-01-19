# frozen_string_literal: true

require "glossaby/ner"

RSpec.describe Glossaby::NER do
  let(:ner) { described_class.new(args: ["/foo.md"]) }
  let(:content) { "# What is Ruby?\n\nRuby is a computer language.\n" }

  describe "#new" do
    it "does not throw" do
      expect { ner }.not_to raise_error
    end
  end

  describe "#nlp" do
    it "returns Spacy::Language" do
      expect { ner.nlp }.not_to raise_error
      expect(ner.nlp.class).to be Spacy::Language
    end
  end

  describe "#preprocessor" do
    it "returns Glossaby::Preprocessor::Markdown" do
      expect(ner.preprocessor.class).to be Glossaby::Preprocessor::Markdown
    end
  end
end
