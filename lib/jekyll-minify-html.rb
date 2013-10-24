require 'html_press'

module Jekyll
  module MinifyHTML
    def output_file(dest, content)
      FileUtils.mkdir_p(File.dirname(dest))
      File.open(dest, 'w') do |f|
        f.write(content)
      end
    end

    def output_html(path, content)
      if @site.config['env'] && @site.config['env'].downcase === 'production'
        content = HtmlPress.press(content)
      end
      output_file(path, content)
    end

  end

  class Post
    include MinifyHTML

    def write(dest)
      dest_path = destination(dest)
      output_html(dest_path, output)
    end
  end

  class Page
    include MinifyHTML

    def write(dest)
      dest_path = destination(dest)
      if File.extname(dest_path).downcase == '.html'
        output_html(dest_path, output)
      else
        output_file(dest_path, output)
      end
    end
  end
  class ConvertiblePage
    include MinifyHTML

    def write(dest)
      dest_path = destination(dest)
      if File.extname(dest_path).downcase == '.html'
        output_html(dest_path, output)
      else
        output_file(dest_path, output)
      end
    end
  end
end

