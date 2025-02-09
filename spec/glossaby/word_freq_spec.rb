# frozen_string_literal: true

require "glossaby/word_freq"

RSpec.describe Glossaby::WordFreq do
  let(:runner) { described_class.new(args: ["spec/data/handbook.html"]) }
  let(:preprocessor) { instance_double(Glossaby::Preprocessor::Markdown) }
  let(:text) { "I like dogs. I liked cats, but cats are not my taste. He is like a cat" }
  let(:keywords) { runner.collect_keywords }

  describe "collect_keyword" do
    before do
      allow(runner).to receive_messages(nlp: Spacy::Language.new("en_core_web_sm"), preprocessor: preprocessor)
      allow(preprocessor).to receive(:process).and_return(text)
    end

    context "when unnormalized words are given" do
      it "returns normalized frequency array" do
        expect(keywords).to be_an Array
      end

      it "returns two 'like' as a verb" do
        expect(keywords.select { |keyword| keyword[:lemma] == "like" && keyword[:pos] == "VERB" }.first[:freq]).to eq 2
      end

      it "returns 'like' as verb with the sentence that used 'like'" do
        result = keywords.select { |keyword| keyword[:lemma] == "like" && keyword[:pos] == "VERB" }.first

        expect(result[:sentence]).to include("I like dogs.")
      end
    end
  end
end
