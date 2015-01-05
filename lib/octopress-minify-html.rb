require 'html_press'
require 'octopress-minify-html/version'

module Octopress
  module MinifyHTML
    def self.output_file(dest, content)
      FileUtils.mkdir_p(File.dirname(dest))
      File.open(dest, 'w') do |f|
        f.write(content)
      end
    end

    def self.output_html(config, path, content)
      minify = config['minify_html']
      production = config['env'].nil? || config['env'] =~ /production/i
      if minify || (minify.nil? && production)
        content = HtmlPress.press(content)
      end
      output_file(path, content)
    end
  end
end

module Jekyll
  class Post
    def write(dest)
      dest_path = destination(dest)
      Octopress::MinifyHTML.output_html(@site.config, dest_path, output)
    end
  end

  class Page
    def write(dest)
      dest_path = destination(dest)
      if File.extname(dest_path).downcase == '.html'
        Octopress::MinifyHTML.output_html(@site.config, dest_path, output)
      else
        Octopress::MinifyHTML.output_file(@site.config, dest_path, output)
      end
    end
  end

  class ConvertiblePage
    def write(dest)
      dest_path = destination(dest)
      if File.extname(dest_path).downcase == '.html'
        Octopress::MinifyHTML.output_html(@site.config, dest_path, output)
      else
        Octopress::MinifyHTML.output_file(@site.config, dest_path, output)
      end
    end
  end

  class Document
    def write(dest)
      dest_path = destination(dest)
      if File.extname(dest_path).downcase == '.html'
        Octopress::MinifyHTML.output_html(@site.config, dest_path, output)
      else
        Octopress::MinifyHTML.output_file(@site.config, dest_path, output)
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
