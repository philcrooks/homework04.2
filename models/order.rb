require_relative('../db/sql_runner')

class Order

  attr_reader :id
  attr_accessor :title, :first_name, :last_name, :address, :quantity, :size

  def Order.all
    sql = "SELECT * FROM orders"
    return SqlRunner.run(sql).map { | order | Order.new(order)}
  end

  def Order.fields_to_string(fields)
    return "" if fields.count == 0
    return fields.first if fields.count == 1
    ultimate = fields.pop
    penultimate = fields.pop
    string = ""
    for field in fields
      string += field + ", "
    end
    string += "#{penultimate} and #{ultimate}"
    return string
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

  def missing_fields
    result = []
    result << "Title" if @title.length == 0
    result << "First Name" if @first_name.length == 0
    result << "Last Name" if @last_name.length == 0
    result << "Address" if @address.length == 0
    result << "Quantity" if quantity == 0
    return result
  end
 
  private

  def normalize(string)
    return string.downcase.capitalize
  end
end