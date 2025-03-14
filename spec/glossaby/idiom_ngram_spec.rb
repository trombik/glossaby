# frozen_string_literal: true

require "glossaby/idiom_ngram"

RSpec.describe Glossaby::IdiomNgram do
  subject(:ngrams) { obj.ngrams }

  let(:obj) { described_class.new(args: ["/foo.md"]) }

  before do
    preprocessor = instance_double(Glossaby::Preprocessor::Markdown)
    allow(preprocessor).to receive(:process).and_return(content)
    allow(obj).to receive_messages(nlp: Spacy::Language.new("en_core_web_sm"), preprocessor: preprocessor)
  end

  describe "#ngrams" do
    let(:content) do
      "That's in addition to global warming dissolving their hunting grounds. \
      That's in addition to writing a string of bestselling books and magazine columns.".gsub("\n", "").gsub(/\s+/, " ")
    end

    it "returns the first N-gram of sentences" do
      expect(ngrams.first.name).to eq "that be in"
    end

    it "returns the last N-gram of sentences" do
      expect(ngrams.last.name).to eq "and magazine column"
    end

    it "does not include N-gram that contains punct" do
      expect(ngrams.map { |ngram| ngram.name =~ /[.,]/ }).not_to include true
    end

    it "does not include N-gram that contains multiple spaces" do
      expect(ngrams.map { |ngram| ngram.name =~ /[ ]{2}/ }).not_to include true
    end

    it "does not include N-gram that starts with space" do
      expect(ngrams.map { |ngram| ngram.name =~ /^[ ]/ }).not_to include true
    end

    it "does not include N-gram that ends with space" do
      expect(ngrams.map { |ngram| ngram.name =~ /[ ]$/ }).not_to include true
    end

    it "does not include any N-gram that is less than 3" do
      expect(ngrams.map { |ngram| ngram.name.split.length < 3 }).not_to include true
    end
  end
end
