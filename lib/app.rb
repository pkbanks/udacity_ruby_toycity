require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "


# For each product in the data set:
products_hash['items'].each do | toy |
  puts '------------'
# Print the name of the toy
  puts toy['title']
  # Print the retail price of the toy
  retail_price = toy['full-price'].to_f
  puts "Price: #{sprintf('%.2f', retail_price)}"
  # Calculate and print the total number of purchases
  puts "Number of purchases: #{toy['purchases'].length}"
  # Calculate and print the total amount of sales
  total_sales = 0
  toy['purchases'].each do |purchase|
    total_sales += purchase['price']
  end
  puts "Total Sales: #{sprintf('%.2f', total_sales)}"
  # Calculate and print the average price the toy sold for
  average_price = total_sales/toy['purchases'].length
  puts "Average price: #{sprintf('%.2f', average_price)}"
  # Calculate and print the average discount (% or $) based off the average sales price
  puts "Average discount: #{sprintf('%.2f',retail_price - average_price)}"
end
  


	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# here we have to group and aggregate by brand.
# however, our data is organized by toy, which
# means that we have instances of a brand that
# can repeat across multiple toys

# we can do this without a database engine, but
# the technique requires lots of looping, which
# would significantly slow down the processes
# once there are a lot of toys and a lot of brands

# the technique is as follows:
#   • inspect each toy and populate a hash of distinct brands
#   • for each toy, aggregate data by brand in an embedded hash

# for each toy, add the brand to our hash if it's not already there
brand_data = {}
products_hash['items'].each do |toy|
  brand = toy['brand']
  unless brand_data.has_key? brand
    # if the brand isn't in our hash, add it
    # and add default values
    brand_data[brand] = {}
    brand_data[brand][:brand_name] = brand
    brand_data[brand][:toy_count] = 0
    brand_data[brand][:cumulative_price] = 0  # we will use this to calculate the average price
    brand_data[brand][:total_revenue] = 0
  end
  
  # update our data for the toy
  brand_data[brand][:toy_count] += 1
  brand_data[brand][:cumulative_price] += toy['full-price'].to_f
  toy['purchases'].each do | purchase |
    brand_data[brand][:total_revenue] += purchase['price'].to_f
  end
end

puts '------------'

# For each brand in the data set:
brand_data.each do | brand, data |
  # Print the name of the brand
  puts data[:brand_name]
  # Count and print the number of the brand's toys we stock
  puts "Number of toys: #{data[:toy_count]}"
  # Calculate and print the average price of the brand's toys
  puts "Average price: #{sprintf('%.2f', data[:cumulative_price] / data[:toy_count])}"
  # Calculate and print the total revenue of all the brand's toy sales combined
  puts "Total revenue: #{sprintf('%.2f', data[:total_revenue])}"
  puts '------------'
end

puts brand_datas  
  
  
