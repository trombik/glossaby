# frozen_string_literal: true

require "glossaby/preprocessor/pdf"

RSpec.describe Glossaby::Preprocessor::PDF do
  let(:preprocessor) { described_class.new("spec/data/normal.pdf", {}) }
  let(:content) do
    "Wondering why Ruby is so popular? Its fans call it a beautiful, artful language.And yet, they say it’s
handy and practical. What gives?

Ruby is a language of careful balance. Its creator, Yukihiro “Matz” Matsumoto, blended parts of his
favorite languages (Perl, Smalltalk, Eiffel,Ada, and Lisp) to form a new language that balanced
functional programming with imperative programming."
  end

  describe "#new" do
    it "does not throw" do
      expect { preprocessor }.not_to raise_error
    end
  end

  describe "#process" do
    it "renders plain text" do
      expect(preprocessor.process).to eq content
    end
  end
end
