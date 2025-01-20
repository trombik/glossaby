# frozen_string_literal: true

require "glossaby/runner"

RSpec.describe Glossaby::Runner do
  let(:runner) { described_class.new(args: ["/foo.md"]) }

  describe "#new" do
    it "does not throw" do
      expect { runner }.not_to raise_error
    end
  end

  describe "#nlp" do
    it "returns Spacy::Language" do
      expect(runner.nlp.class).to be Spacy::Language
    end
  end

  describe "#preprocessor" do
    it "returns Glossaby::Preprocessor::Markdown" do
      expect(runner.preprocessor.class).to be Glossaby::Preprocessor::Markdown
    end
  end
end
