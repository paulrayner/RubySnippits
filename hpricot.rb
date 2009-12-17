require 'rubygems'
require 'hpricot'

xml = %{
<status>
  <id>1</id>
  <created_at>a date</created_at>
  <text>some text</text>
</status> 
}

doc = Hpricot::XML(xml)
(doc/:status).each do |status|
  ['id', 'created_at', 'text'].each do |el|
    puts "#{el}: #{status.at(el).innerHTML}" 
  end
end