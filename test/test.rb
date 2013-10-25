require 'colorator'

has_failed  = false
config      = File.read("_config.yml")
config_prod = "#{config}env: production"

def test(type, version)
  build(version)
  if diff = diff_file(type, version)
    puts "Jekyll #{version}: Failed #{type}".red
    puts diff
    has_failed = true
  else
    puts "Jekyll #{version}: Passed #{type}".green
  end
end

def build(version)
  ENV['BUNDLE_GEMFILE'] = "jekyll-#{version}/Gemfile"
  build =  "rm -rf site && bundle exec jekyll"
  build += " build --trace" if version === "1.0"
  `#{build}`
end

def diff_file(file, version)
  diff = `diff jekyll-#{version}/expected/#{file}.html site/index.html`
  if diff.size > 0
    diff
  else
    false
  end
end

test('uncompressed', "1.0")
test('uncompressed', "0.12")

File.open("_config.yml", "w") do |f|
  f.write(config_prod) 
end

test('compressed', "1.0")
test('compressed', "0.12")

# Reset original config without compression enabled
File.open("_config.yml", "w") do |f|
  f.write(config)
end

abort if has_failed

