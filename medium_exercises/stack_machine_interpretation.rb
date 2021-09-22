class Minilang
  VALID_COMMANDS = %w(pop push add sub mult div mod print)

  attr_reader :commands
  attr_accessor :stack, :register

  def initialize(commands)
    @commands = extract_commands(commands)
    self.stack = []
    self.register = 0
  end

  def extract_commands(command_string)
    command_string.split(" ").map { |command| command.downcase }
  end

  def number_command?(string)
    string.to_i.to_s == string
  end

  def n(number)
    self.register = number.to_i
  end

  def push
    stack << register
  end

  def pop
    self.register = stack.pop
  end
  
  def add
    self.register = (self.register += stack.pop)
  end

  def sub
    self.register = (self.register -= stack.pop)
  end

  def mult
    self.register = (self.register *= stack.pop)
  end

  def div
    self.register = (self.register /= stack.pop)
  end

  def mod
    self.register = (self.register % stack.pop)
  end

  def print
    output = register.nil? ? "Empty Stack!" : register
    puts output
    # could also do:
    # begin
    # if register.nil? 
    #   raise StackError, "Empty Stack!"
    # rescue => e
    #   puts e.message
    # end
  end
  
  def eval(degrees_c: nil, degrees_f: nil)
    commands[2] = format(commands[2], degrees_c: degrees_c) if degrees_c # Further Exploration 1
    commands[2] = format(commands[2], degrees_f: degrees_f) if degrees_f # Further Exploration 1
    commands.each do |command|
      if command =~ /\A[-+]?\d+\z/
        n(command)
      elsif VALID_COMMANDS.include?(command)
        send(command)
      else
        begin
          raise TokenError, "Invalid Token: #{command.upcase}"
        rescue => e
          puts e.message
        end
      end
    end
  end

end

class TokenError < StandardError; end

class StackError < StandardError; end

CENTIGRADE_TO_FARENHEIT =
'5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'

FARENHEIT_TO_CELCIUS =
'9 PUSH %<degrees_f>d PUSH 32 SUB PUSH 5 MULT DIV PRINT'

Minilang.new(CENTIGRADE_TO_FARENHEIT).eval(degrees_c: 0)

Minilang.new(FARENHEIT_TO_CELCIUS).eval(degrees_f: 32)

# Minilang.new('PRINT').eval
# # 0

# Minilang.new('5 PUSH 3 MULT PRINT').eval
# # 15

# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8

# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

# Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!

# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6

# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB

# Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8

# Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)