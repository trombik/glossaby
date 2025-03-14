# Glossaby

A ruby gem to help create glossary from English documents.

## Features

* [x] Create a list of Named Entity
* [x] Create a histogram of frequently appearing words
* [x] Create a histogram of frequently appearing noun phrases
* Create a histogram of frequently appearing expressions
    * [x] N-gram

## Preprocessors

* [x] Markdown
* [x] PDF
* [x] HTML
* [x] Word (.docx only)
* [ ] XLIFF

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add glossaby
```

If bundler is not being used to manage dependencies, install the gem by
executing:

```bash
gem install glossaby
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/trombik/glossaby.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
