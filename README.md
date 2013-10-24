# Jekyll Minify Html

[![Gem Version](https://badge.fury.io/rb/jekyll-minify-html.png)](http://badge.fury.io/rb/jekyll-minify-html) [![Build Status](https://travis-ci.org/imathis/jekyll-minify-html.png)](https://travis-ci.org/imathis/jekyll-minify-html)

Minify Jekyll's HTML output with [html_press](https://github.com/stereobooster/html_press)

## Installation

Add this line to your application's Gemfile under
the :jekyll_plugins group:

```ruby
group :jekyll_plugins do
  gem 'jekyll-minify-html'
end
```

And then execute:

    $ bundle

Next add this to your plugins folder to automatically load any Jekyll plugins in your :jekyll_plugins group.

```ruby
# in _plugins/bundler.rb
require "bundler/setup"
Bundler.require(:jekyll_plugins)

```

Or you can just create a ruby file in your Jekyll plugins directory with the line `require "jekyll-minify-html"`

## Usage

Set Jekyll's environment to production in your Jekyll configuration file.

```yml
env: production
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
