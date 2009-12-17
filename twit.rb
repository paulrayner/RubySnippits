# From http://ruby.about.com/od/networking/qt/twitterparse.htm
require 'rubygems'
require 'hpricot'
require 'net/http'

$username = 'virtualgenius'
$password = '2TzJ4Wf5'

def twitter(command, opts={}, type=:get)
  # Open an HTTP connection to twitter.com
  twitter = Net::HTTP.start('twitter.com')

  # Depending on the request type, create either
  # an HTTP::Get or HTTP::Post object
  case type
  when :get
    # Append the options to the URL
    command << "?" + opts.map{|k,v| "#{k}=#{v}" }.join('&')
    req = Net::HTTP::Get.new(command)

  when :post
    # Set the form data with options
    req = Net::HTTP::Post.new(command)
    req.set_form_data(opts)
  end

  # Set up the authentication and
  # make the request
  req.basic_auth( $username, $password )
  res = twitter.request(req)

  # Raise an exception unless Twitter
  # returned an OK result
  unless res.is_a? Net::HTTPOK
    doc = Hpricot(res.body)
    raise "#{(doc/'request').inner_html}: #{(doc/'error').inner_html}"
  end

  # Return the request body
  return Hpricot(res.body)
end

doc = twitter('/statuses/friends_timeline.xml')
#puts "#{doc}"

(doc/'status').each do|st|
  user = (st/'user name').inner_html
  screen_name = (st/'user screen_name').inner_html
  text = (st/'text').inner_html
  statuses_count = (st/'statuses_count').inner_html

  puts "#{user} (#{screen_name}) said #{text} - #{statuses_count}"
end