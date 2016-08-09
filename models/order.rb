require_relative('../db/sql_runner')

class Order

  attr_reader :id, :title, :first_name, :last_name, :address, :quantity, :size

  def Order.all
    sql = "SELECT * FROM orders"
    return SqlRunner.run(sql).map { | order | Order.new(order)}
  end

  def initialize(options)
    @title = options["title"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @address = options["address"]
    @quantity = options["quantity"].to_i
    @size = options["size"].to_i
    @id = options["id"].to_i
  end

  def save
    sql = "INSERT INTO orders (title, first_name, last_name, address, quantity, size) VALUES ('#{@title}', '#{@first_name}', '#{last_name}', '#{address}', #{quantity}, #{size}) RETURNING *"
    @id = SqlRunner.run(sql).first["id"].to_i
  end

  def full_name
    return "#{normalize(@title)} #{normalize(@first_name)} #{normalize(@last_name)}"
  end

  private

  def normalize(string)
    return string.downcase.capitalize
  end
end