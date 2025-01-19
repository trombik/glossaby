# frozen_string_literal: true

require "glossaby/ner"

RSpec.describe Glossaby::NER do
  let(:ner) { described_class.new(args: ["/foo.md"]) }
  let(:content) { "What is Ruby?\n\nRuby is a computer language.\n" }

  describe "#new" do
    it "does not throw" do
      expect { ner }.not_to raise_error
    end
  end

  describe "#nlp" do
    it "returns Spacy::Language" do
      expect(ner.nlp.class).to be Spacy::Language
    end
  end

  describe "#preprocessor" do
    it "returns Glossaby::Preprocessor::Markdown" do
      expect(ner.preprocessor.class).to be Glossaby::Preprocessor::Markdown
    end
  end

  describe "#collect_keyword" do
    it "returns a hash of keywords" do
      preprocessor = instance_double(Glossaby::Preprocessor::Markdown)
      allow(preprocessor).to receive(:process).and_return(content)
      allow(ner).to receive_messages(nlp: Spacy::Language.new("en_core_web_sm"), preprocessor: preprocessor)

      expect(ner.collect_keyword).to eq({ "Ruby" => { count: 1, label: "PERSON" } })
    end
  end
end
