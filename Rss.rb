def fetch_rss_items(url, max_items = nil)
  %w{open-uri rss/0.9 rss/1.0 rss/2.0 rss/parser}.each do |lib|
    require(lib)
  end
  rss = RSS::Parser.parse(open(url).read)
  rss.items[0...(max_items ? max_items : rss.items.length)]
end

url = ARGV[0]
max_items = ARGV[1].to_i
puts "Loading #{max_items} items from #{url}"
puts

items = fetch_rss_items(url, max_items)
titles = items.collect { |item| item.title }

puts titles