# frozen_string_literal: true

require "glossaby/ner"

RSpec.describe Glossaby::NER do
  let(:ner) { described_class.new(args: ["/foo.md"]) }
  let(:content) { "What is Ruby?\n\nRuby is a computer language.\n" }

  describe "#collect_keyword" do
    before do
      preprocessor = instance_double(Glossaby::Preprocessor::Markdown)
      allow(preprocessor).to receive(:process).and_return(content)
      allow(ner).to receive_messages(nlp: Spacy::Language.new("en_core_web_sm"), preprocessor: preprocessor)
    end

    it "contains `Ruby` as NER" do
      keywords = ner.collect_keyword

      expect(keywords[keywords.find_by_name("Ruby")].name).to eq "Ruby"
    end

    it "counts `Ruby` twice" do
      keywords = ner.collect_keyword

      expect(keywords[keywords.find_by_name("Ruby")].count).to eq 2
    end
  end
end
