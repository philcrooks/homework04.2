require ("minitest/autorun")
require ("minitest/rg")
require_relative("../models/order")

class TestOrder < Minitest::Test
  def setup
    @order = Order.new(
      {
        "title" => "mr",
        "first_name" => "ReGinald",
        "last_name" => "Dwight",
        "address" => "2A, The Mews, Henley-on-Thames",
        "quantity" => 3,
        "size" => 11
      }
    )
  end

  def test_new
    assert_equal("mr", @order.title)
    assert_equal("ReGinald", @order.first_name)
    assert_equal("Dwight", @order.last_name)
    assert_equal("2A, The Mews, Henley-on-Thames", @order.address)
    assert_equal(3, @order.quantity)
    assert_equal(11, @order.size)
  end

  def test_name
    assert_equal("Mr Reginald Dwight", @order.full_name)
  end

  def test_save
    @order.save
    retrieved_order = Order.all.last
    assert_equal(true, retrieved_order.id > 0)
  end
end
