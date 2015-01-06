require 'html_press'
require 'octopress-hooks'
require 'octopress-minify-html/version'

module Octopress
  module MinifyHTML
    class MinifyPage < Hooks::All
      def post_render(item)
        item.output = HtmlPress.press(item.output) if minify?(item.site.config)
      end

      def minify?(config)
        minify = config['minify_html']
        production = config['env'].nil? || config['env'] =~ /production/i
        minify || (minify.nil? && production)
      end
    end
  end
end

if defined? Octopress::Docs
  Octopress::Docs.add({
    name:        "Octopress Minify HTML",
    gem:         "octopress-minify-html",
    description: "Automatically minifies HTML output for your Jekyll site.",
    path:        File.expand_path(File.join(File.dirname(__FILE__), "../")),
    source_url:  "https://github.com/octopress/minify-html",
    version:     Octopress::MinifyHTML::VERSION
  })
end
