require_relative ('order')

class EmptyOrder < Order
  def initialize()
    super({})
  end

  def save()
    return nil
  end
end