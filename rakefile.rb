# Although this syntax looks a little funky, it is legal Ruby. We are constructing a hash where the key is :name and the value 
# for that key is the list of prerequisites. It is equivalent to the following …
#  hash = Hash.new
#  hash[:name] = [:prereq1, :prereq2]
#  task(hash)
  
namespace :alcoholic do
desc "This task will purchase your Vodka"
task :purchaseAlcohol do
	puts "Purchased Vodka"
end

desc "This task will get your glass"
task :getGlass do
	puts "Glass in hand"
end

desc "This task will mix a good cocktail"
task :mixDrink => [:purchaseAlcohol, :getGlass] do
	puts "Mixed Fuzzy Navel"
end

desc "This task will mix one drink too many"
task :getSmashed => :mixDrink do
	puts "Floor...puke!"
end
end