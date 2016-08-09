require_relative('../db/sql_runner')

class Item

  attr_reader :id, :size
  attr_accessor :available

  def Item.available()
    sql = "SELECT * FROM items WHERE available > 0 ORDER BY id ASC"
    return SqlRunner.run(sql).map { | item | Item.new(item) }
  end

  def Item.all()
    sql = "SELECT * FROM items ORDER BY id ASC"
    return SqlRunner.run(sql).map { | item | Item.new(item) }
  end

  def Item.clear()
    sql = "DELETE FROM items"
    SqlRunner.run(sql)
  end

  def Item.get_by_size(size)
    sql = "SELECT * FROM items WHERE size = #{size}"
    return Item.new(SqlRunner.run(sql).first)
  end

  def initialize(options)
    @size = options["size"].to_i
    @available = options["available"].to_i
    @id = options["id"].to_i
  end

  def save()
    sql = "INSERT INTO items (size, available) VALUES (#{@size}, #{@available}) RETURNING *"
    @id = SqlRunner.run(sql).first["id"].to_i
  end

  def update()
    sql = "UPDATE items SET (available) = (#{@available}) WHERE id = #{@id}"
    SqlRunner.run(sql)
  end
end