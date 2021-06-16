class Command
end

class UnaryCommand < Command
  def execute(a)
    raise 'Not implemented!'
  end
end

class BinaryCommand < Command
  def execute(a, b)
    raise 'Not implemented!'
  end
end

# Binary commands

class PlusCommand < BinaryCommand
  def execute(a, b) a + b end
end

class MinusCommand < BinaryCommand
  def execute(a, b) a - b end
end

class MulCommand < BinaryCommand
  def execute(a, b) a * b end
end

class DivCommand < BinaryCommand
  def execute(a, b) 
    if b == 0
      puts 'Division by zero!'

      return nil;
    end

    a / b
  end
end

class ModCommand < BinaryCommand
  def execute(a, b) a % b end
end

class PowCommand < BinaryCommand
  def execute(a, b) a ** b end
end

# Unary commands

class IncCommand < UnaryCommand
  def execute(a) a + 1 end
end

class DecCommand < UnaryCommand
  def execute(a) a - 1 end
end

class SqrtCommand < UnaryCommand
  def execute(a) Math.sqrt(a) end
end

class SinCommand < UnaryCommand
  def execute(a) Math.sin(a) end
end

class CosCommand < UnaryCommand
  def execute(a) Math.cos(a) end
end

class TanCommand < UnaryCommand
  def execute(a) Math.tan(a) end
end

class CtanCommand < UnaryCommand
  def execute(a) Math.ctan(a) end
end

class ExpCommand < UnaryCommand
  def execute(a) Math.exp(a) end
end

class LnCommand < UnaryCommand
  def execute(a) Math.log(a) end
end

class FactCommand < UnaryCommand
  def execute(a) 
    return nil if a < 0

    a > 1 ? a * execute(a - 1) : 1;
  end
end

# Shared
$memory_cell = nil
$stack = []

class MemWriteCommand < UnaryCommand
  def execute(a) 
    $memory_cell = a
    puts "Value #{a} has been saved to memory cell, type \"mr\" to use it"
    a
  end
end

class MemReadCommand < UnaryCommand
  def execute(a)
    puts "Getting value #{$memory_cell} from memory cell"
    $memory_cell
  end
end

class PushCommand < UnaryCommand
  def execute(a)
    puts "Value #{a} has been pushed onto the stack, type \"pop\" to get it"
    $stack.push(a)

    nil
  end
end

class PopCommand < UnaryCommand
  def execute(a)
    val = $stack.pop

    puts val.nil? ? "No values in stack" : "Getting value #{val} fron stack"

    val
  end
end

class PrimesCommand < UnaryCommand
  def execute(a)
    primes = $stack.select { |num| is_prime_num(num) }

    puts "Prime numbers in stack: #{primes}"
  end

  private

  def is_prime_num(num)
    range = 2..num - 1
    range.each { |n|
      return false if num % n == 0
    }

    true
  end
end