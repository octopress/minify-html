require 'colorator'

has_failed   = false
config       = File.read("_config.yml")
disabled     = "#{config}minify_html: false"
minify       = "#{config}env: production"
override_off = "#{config}env: production\nminify_html: false"
override_on  = "#{config}env: development\nminify_html: true"

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

## Test default
puts "Testing with no configuration"

test('compressed', "1.0")
test('compressed', "0.12")

puts "Testing with no minify_html: false"
File.open("_config.yml", "w") { |f| f.write(disabled) }

test('uncompressed', "1.0")
test('uncompressed', "0.12")

puts "Testing with env: production"
File.open("_config.yml", "w") { |f| f.write(minify) }

test('compressed', "1.0")
test('compressed', "0.12")

puts "Testing with env: production and minify_html: false"
File.open("_config.yml", "w") { |f| f.write(override_off) }

test('uncompressed', "1.0")
test('uncompressed', "0.12")

puts "Testing with env: production and minify_html: false"
File.open("_config.yml", "w") { |f| f.write(override_on) }

test('compressed', "1.0")
test('compressed', "0.12")

# Reset original config without compression enabled
File.open("_config.yml", "w") do |f|
  f.write(config)
end

abort if has_failed

