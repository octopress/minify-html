require 'colorator'

has_failed = false

`bundle exec jekyll build --config _config.yml,_production.yml --trace`

compressed_diff = `diff expected/compressed.html site/index.html`

`bundle exec jekyll build --trace`

uncompressed_diff = `diff expected/uncompressed.html site/index.html`

if compressed_diff.size == 0
  puts "Compression passed".green
else
  puts "Compression failed".red
  puts compressed_diff
  has_failed = true
end

if uncompressed_diff.size == 0
  puts "Disabling compression passed".green
else
  puts "Disabling compression failed".red
  puts uncompressed_diff
  has_failed = true
end

abort if has_failed

