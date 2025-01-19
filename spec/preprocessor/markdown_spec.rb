# frozen_string_literal: true

require "glossaby/preprocessor/markdown"

RSpec.describe Glossaby::Preprocessor::Markdown do
  let(:preprocessor) { described_class.new("/foo") }
  let(:content) { "# foo\nbar\n" }

  describe "#new" do
    it "does not throw" do
      expect { preprocessor }.not_to raise_error
    end
  end

  describe "#process" do
    it "renders plain text" do
      allow(preprocessor).to receive(:read).and_return(content)
      expect(preprocessor.process).to eq "foo\nbar\n"
    end
  end
end
