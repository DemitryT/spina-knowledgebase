[![Build Status](https://travis-ci.org/SpinaCMS/spina-knowledgebase.svg?branch=master)](https://travis-ci.org/initforthe/spina-knowledgebase) [![Code Climate](https://codeclimate.com/github/initforthe/spina-knowledgebase/badges/gpa.svg)](https://codeclimate.com/github/initforthe/spina-knowledgebase) [![Test Coverage](https://codeclimate.com/github/initforthe/spina-knowledgebase/badges/coverage.svg)](https://codeclimate.com/github/initforthe/spina-knowledgebase/coverage)

# Spina::Knowledgebase
Simple knowledgebase engine for [Spina CMS](https://www.spinacms.com/). It supports articles and categories.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'spina-knowledgebase'
```

And then execute:
```bash
$ bundle
```

And install:
```bash
$ rails g spina_knowledgebase:install
```

Or install it yourself as:
```bash
$ gem install spina-knowledgebase
```

Add to your Spina theme:
```ruby
# config/initializers/themes/theme.rb

Spina::Theme.register do |theme|
  # ...
  theme.plugins = ['knowledgebase']
end

```

## Contributing
The version of Spina to develop this engine against is defined in the gemspec. To override the version of refinery to develop against, edit the project Gemfile to point to a local path containing a clone of Spina CMS.

### Testing

With rake spec
```bash
$ bundle exec rake spec
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
