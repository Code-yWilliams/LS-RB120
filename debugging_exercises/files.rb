# You started writing a very basic class for handling files.
# However, when you begin to write some simple test code, yo
#  get a NameError. The error message complains of an uninitialized
#  constant File::FORMAT.

# What is the problem and what are possible ways to fix it?

# class File
#   attr_accessor :name, :byte_content

#   def initialize(name)
#     @name = name
#   end

#   alias_method :read,  :byte_content
#   alias_method :write, :byte_content=

#   def copy(target_file_name)
#     target_file = self.class.new(target_file_name)
#     target_file.write(read)

#     target_file
#   end

#   def to_s
#     "#{name}.#{FORMAT}"
#   end
# end

# class MarkdownFile < File
#   FORMAT = :md
# end

# class VectorGraphicsFile < File
#   FORMAT = :svg
# end

# class MP3File < File
#   FORMAT = :mp3
# end

# # Test

# blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
# blog_post.write('Content will be added soon!'.bytes)

# copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

# puts copy_of_blog_post.is_a? MarkdownFile     # true
# puts copy_of_blog_post.read == blog_post.read # true

# puts blog_post

class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{self.class::FORMAT}" # SOLUTION. constants have lexical scope so this method looks
    # for the FORMAT constant within the File class or its ancestors (not its sub classes).
    # Since each sub class has its own FORMAT constant,
    # We need to specify that it should look for the constant's value within the class of the calling
    # object. We could also just initialize instance variables with the format type within each sub class
    # but this doesn't convey the idea that file formats are not changeable for each file type. Could
    # also define a format method within each subclass that returns each format, and then
    # interpolate that value in the to_s method within the superclass File. Could also provide a unique
    # to_s method within each subclass, but thats not very DRY
    # It is just a matter of choice.
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post