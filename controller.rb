require ('sinatra')
require ('sinatra/contrib/all')
require ('pry-byebug')
require_relative('models/item')
require_relative('models/order')

get( '/order/new' ) do
  @title = "Buy Shoos"
  @stock = Item.available
  erb( :new )
end

post( '/order' ) do
  @order = Order.new(params)
  @item = Item.get_by_size(@order.size)
  if @item.available >= @order.quantity
    # Save the order
    @title = "Order Confirmation"
    @order.save
    @item.available -= @order.quantity
    @item.update
    erb( :create )
  else
    @title = "Problem Order"
    erb( :problem )
  end
end

get( '/order' ) do
  @title = "Shoos Order Index"
  @orders = Order.all
  erb( :index )
end