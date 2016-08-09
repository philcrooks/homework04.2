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

  def test_missing_field
    assert_equal([], @order.missing_fields)
    @order.first_name = ""
    assert_equal(1, @order.missing_fields.count)
    assert_equal("First Name", @order.missing_fields.first)
    @order.last_name = ""
    @order.title = ""
    fields = @order.missing_fields
    assert_equal(3, fields.count)
    assert_equal("Title, First Name and Last Name", Order.fields_to_string(fields))
  end
end
