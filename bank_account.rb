class Account
  attr_reader :name, :balance
  def initialize(name, balance=100)
    @name = name
    @balance = balance
  end
  def display_balance(pin_number)
    puts pin_number == pin ? "Balance: $#{self.balance}." : self.pin_error
  end
  def withdraw(pin_number, amount)
    pin_number == pin ? (@balance -= amount; puts "Withdrew #{amount}. New balance: #@balance.") : (puts self.pin_error)
  end
  private
  def pin
    @pin = 1234
  end
  def pin_error
    "Access denied: incorrect PIN."
  end
end

checking_account = Account.new("Cody Williams", 13_101)