require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
TEXT

INPUT = read_input
PROGRAM = INPUT.split "\n"

variations = []
PROGRAM.each_with_index do |row, index|
  if row.start_with?('jmp')
    another = PROGRAM.dup
    another[index] = another[index].sub 'jmp', 'nop'
    variations.push another
  elsif row.start_with?('nop')
    another = PROGRAM.dup
    another[index] = another[index].sub 'nop', 'jmp'
    variations.push another
  end
end

def execute(program)
  visited = []
  accumulator = 0
  index = 0

  loop do
    # Endless loop
    break unless visited.uniq == visited

    # End of program or Invalid program jump
    break if index >= program.size
    # Invalid program jump
    break if index < 0

    # Parse
    instruction, value = program[index].split

    visited.push index

    # Execute
    case instruction
    when 'acc'
      accumulator += value.to_i
      index += 1
    when 'jmp'
      index += value.to_i
    when 'nop'
      index += 1
    end
  end

  [accumulator, visited.uniq == visited]
end

variations.each do |variation|
  accumulator, completed = execute variation

  if completed
    puts accumulator
    break
  end
end
