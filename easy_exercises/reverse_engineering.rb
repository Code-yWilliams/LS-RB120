# Write a class that will display:

# ABC
# xyz

# my_data = Transform.new('abc')
# puts my_data.uppercase
# puts Transform.lowercase('XYZ')


class Transform
  attr_accessor :data
  def initialize(data)
    @data = data
  end
  def uppercase
    self.data.upcase
  end
  def self.lowercase(data)
    data.downcase
  end
end


my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')