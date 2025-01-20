# frozen_string_literal: true

require_relative "lib/glossaby/version"

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name = "glossaby"
  spec.version = Glossaby::VERSION
  spec.authors = ["Tomoyuki Sakurai"]
  spec.email = ["y@trombik.org"]

  spec.summary = "TODO: Write a short summary, because RubyGems requires one."
  spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "commander", "~> 5.0.0"
  spec.add_dependency "nokogiri", "~> 1.18.2"
  spec.add_dependency "pdf-reader", "~> 2.13.0"
  spec.add_dependency "redcarpet", "~> 3.6.0"
  spec.add_dependency "ruby-spacy", "~> 0.2.3"
  spec.add_dependency "terminal-table", "~> 3.0.2"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
# rubocop:enable Metrics/BlockLength
