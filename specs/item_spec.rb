require ("minitest/autorun")
require ("minitest/rg")
require_relative("../models/item")

class TestItem < Minitest::Test
  def setup
    # Items added to database by db/setup.rb
    @items = Item.all
    @item = @items.first
    @availability = @item.available
  end

  def test_number_of_items
    # the only sizes available are 7,8,9,10,11
    assert_equal(5, @items.count)
  end

  def test_update
    available = @item.available
    @item.available -= 1
    @item.update
    assert_equal(available-1, Item.all.first.available)
  end

  def test_available
    @item.available = 1
    @item.update
    assert_equal(true, @item.id == Item.available.first.id)
    @item.available = 0
    @item.update
    assert_equal(false, @item.id == Item.available.first.id)
  end

  def test_size_availability
    @item.available = 5
    @item.update
    assert_equal(5, Item.get_by_size(@item.size).available)
  end

  def test_reset_availability
    @item.available = @availability
    @item.update
  end
end


