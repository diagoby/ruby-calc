require './commands'

$commands = {
  # Working with memory
  'mw' => MemWriteCommand.new,
  'mr' => MemReadCommand.new,
  'push' => PushCommand.new,
  'pop' => PopCommand.new,
  'primes' => PrimesCommand.new,
  # Basic binary ops
  '+' => PlusCommand.new,
  '*' => MulCommand.new,
  '-' => MinusCommand.new,
  '/' => DivCommand.new,
  'mod' => ModCommand.new,
  'pow' => PowCommand.new,
  # Basic unary ops
  '++' => IncCommand.new,
  '--' => DecCommand.new,
  'sqrt' => SqrtCommand.new,
  'sin' => SinCommand.new,
  'cos' => CosCommand.new,
  'tan' => TanCommand.new,
  'ctan' => CtanCommand.new,
  'exp' => ExpCommand.new,
  'ln' => LnCommand.new,
  '!' => FactCommand.new,
}

def get_operand(label, default = nil)
  operand = default

  if !operand.nil?
    print "Enter the #{label} argument (#{default}): "
  else
    print "Enter the #{label} argument: "
  end

  input = gets.chomp.strip

  return operand if input.empty?
  return $commands['mr'].execute(nil) if input == 'mr'
  return $commands['pop'].execute(nil) if input == 'pop'

  begin
    Float(input)
  rescue
    puts 'You should enter a valid argument value'
    return get_operand(label)
  end
end

def get_operator
  print 'Choose the operator: '
  operator = gets.chomp

  if !$commands.keys.include?(operator)
    print 'You should choose a valid math operator! '
    return get_operator
  end

  operator
end

def run(default_operand = nil)
  first_operand = get_operand('first', default_operand)
  command = $commands[get_operator]
  result = nil

  if command.is_a?(UnaryCommand)
    result = command.execute(first_operand) 
  else
    second_operand = get_operand('second')
    result = command.execute(first_operand, second_operand)
  end

  puts "Result: #{result}"
  
  run(result)
end

run nil

