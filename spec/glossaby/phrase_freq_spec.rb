# frozen_string_literal: true

require "glossaby/phrase_freq"

RSpec.describe Glossaby::PhraseFreq do
  let(:runner) { described_class.new(args: ["spec/data/handbook.html"]) }
  let(:preprocessor) { instance_double(Glossaby::Preprocessor::Markdown) }
  let(:text) do
    "From software development to factory automation, inventory control to
    azimuth correction of remote satellite antenna; if it can be done with a
    commercial UNIX® product then it is more than likely that you can do it
    with FreeBSD too! 'BSD' stands for Berkeley Software Distribution. This is
    an operating system that I use. I am a managing director. I have white cats.".gsub("\n", "").gsub(/[ ]+/, " ")
  end
  let(:phrases) { runner.collect_phrases }

  describe "#singularize" do
    it "returns a singular form from a plural form" do
      text = "I have pens"
      doc = runner.nlp.read(text)
      token = doc[-1]

      expect(runner.singularize(token)).to eq "pen"
    end
  end

  describe "collect_keyword" do
    before do
      allow(runner).to receive_messages(nlp: Spacy::Language.new("en_core_web_sm"), preprocessor: preprocessor)
      allow(preprocessor).to receive(:process).and_return(text)
    end

    it "returns frequency array" do
      puts text
      expect(phrases).to be_an Array
    end

    it "returns NPs" do
      expect(runner.collect_phrases.map(&:name)).to include(
        "software development",
        "factory automation",
        "remote satellite antenna"
      )
    end

    it "does not contain single word NPs" do
      expect(runner.collect_phrases.map(&:name)).not_to include(
        "it",
        "you"
      )
    end

    it "does not contain 'an operating system'" do
      expect(runner.collect_phrases.map(&:name)).not_to include(
        "an operating system"
      )
    end

    it "removes 'that' from noun phrases" do
      expect(runner.collect_phrases.map(&:name)).to include(
        "operating system"
      )
    end

    it "contains a lowered phrase" do
      expect(runner.collect_phrases.map(&:name)).to include(
        "berkeley software distribution"
      )
    end

    it "does not reject a phrase with a verb" do
      expect(runner.collect_phrases.map(&:name)).to include(
        "managing director"
      )
    end

    it "does not reject a phrase with an adjective" do
      expect(runner.collect_phrases.map(&:name)).to include(
        "white cat"
      )
    end
  end
end
