require ('sinatra')
require ('sinatra/contrib/all')
require ('pry-byebug')
require_relative('models/item')
require_relative('models/order')
require_relative('models/empty_order')

get( '/order/new' ) do
  @message = ""
  @title = "Buy Shoos"
  @stock = Item.available
  @order = EmptyOrder.new()
  erb( :new )
end

post( '/order/new' ) do
  @order = Order.new(params)
  missing_fields = @order.missing_fields
  @item = Item.get_by_size(@order.size)
  if (missing_fields.count == 0) && (@item.available >= @order.quantity)
    # Save the order
    @title = "Order Confirmation"
    @order.save
    @item.available -= @order.quantity
    @item.update
    erb( :create )
  else
    if missing_fields.count > 0 
      @message = "You forgot to provide a #{Order.fields_to_string(missing_fields)}."
    else
      @message = "You tried to order #{@order.quantity} pairs of size #{@order.size} Shoos but we only have #{@item.available} pairs available."
    end
    @title = "Buy Shoos"
    @stock = Item.available
    erb( :new )
  end
end

get( '/order' ) do
  @title = "Shoos Order Index"
  @orders = Order.all
  erb( :index )
end