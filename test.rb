class Class
  attr_accessor :var
  def initialize(var_value)
    @var = var_value
  end

  def var_compare(other)
    self.waffle > other.waffle
  end

  private
  def waffle
    @var
  end
end

object1 = Class.new(10)
object2 = Class.new(12)

puts object2.var_compare(object1)