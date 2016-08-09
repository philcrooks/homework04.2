require('pry-byebug')
require_relative('../models/item')

def setup
  Item.clear
  # the only sizes available are 7,8,9,10,11
  Item.new({ "size" => 7, "available" => 1 }).save
  Item.new({ "size" => 8, "available" => 2 }).save
  Item.new({ "size" => 9, "available" => 1 }).save
  Item.new({ "size" => 10, "available" => 3 }).save
  Item.new({ "size" => 11, "available" => 5 }).save
end

setup

# binding.pry
# nil
