# Consider the following class:

class Machine
  attr_writer :switch

  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

# Modify this class so both flip_switch and the setter method switch= are private methods.
# Further Exploration:
# Add a private getter for @switch to the Machine class, and add a method to Machine that
# shows how to use that getter.


class Machine

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def show_switch # Further Exploration
    switch
  end

  private

  def flip_switch(desired_state)
    self.switch = desired_state
  end

  attr_writer :switch

  attr_reader :switch # Further Exploration

end
