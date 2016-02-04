require 'html_press'

require 'octopress-minify-html/version'

module Octopress
  module MinifyHTML

    extend self

    def minify(item)
      options = symbolize(item.site.config['html_press'] || {})
      if minify?(item)
        HtmlPress.press(item.output, options)
      else
        item.output
      end
    end

    def minify?(item)
      config = item.site.config
      if item.destination(config['destination']).end_with?('html')
        minify = config['minify_html']
        production = config['env'].nil? || config['env'] =~ /production/i

        # Minify if configuration explicitly requires minification
        # or if Jekyll env is production
        minify || (minify.nil? && production)
      end
    end

    def symbolize(obj)
      return obj.reduce({}) do |memo, (k, v)|
        memo.tap { |m| m[k.to_sym] = symbolize(v) }
      end if obj.is_a? Hash
        
      return obj.reduce([]) do |memo, v| 
        memo << symbolize(v); memo
      end if obj.is_a? Array
      
      obj
    end

    if defined?(Jekyll::Hooks)
      Jekyll::Hooks.register [:posts, :pages, :documents], :post_render do |item|
        item.output = MinifyHTML.minify(item)
      end
    else
      require 'octopress-hooks'
      class MinifyPage < Octopress::Hooks::All
        def post_render(item)
          item.output = MinifyHTML.minify(item)
        end
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
