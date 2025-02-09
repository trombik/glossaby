# frozen_string_literal: true

require "glossaby/preprocessor/html"

RSpec.describe Glossaby::Preprocessor::HTML do
  let(:preprocessor) { described_class.new("/foo") }
  let(:content) do
    "<html>
      <head>
        <title>Title</title>
      </head>
      <body>
        <h1>H1</h1>
        <h2>H2</h2>
        <ul>
          <li>Item1</li>
        </ul>
        <code>Code</code>
        <pre>Pre</pre>
        <pre><code>Code</code></pre>
      </body>
    </html>"
  end

  describe "#new" do
    it "does not throw" do
      expect { preprocessor }.not_to raise_error
    end
  end

  describe "#process" do
    it "renders plain text, removing <code> and <pre>" do
      allow(preprocessor).to receive(:read).and_return(content)
      expect(preprocessor.process).to eq " Title H1 H2 Item1 "
    end
  end
end
