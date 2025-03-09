# frozen_string_literal: true

require "glossaby/preprocessor/markdown"

RSpec.describe Glossaby::Preprocessor::Markdown do
  let(:preprocessor) { described_class.new("/foo", {}) }
  let(:content) { "# foo\nbar\n" }
  let(:content_with_code_block) do
    "# foo
bar

```ruby
buz
```"
  end

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

    it "renders plain text without code block" do
      allow(preprocessor).to receive(:read).and_return(content_with_code_block)
      expect(preprocessor.process).to eq "foo\nbar\n"
    end
  end
end
