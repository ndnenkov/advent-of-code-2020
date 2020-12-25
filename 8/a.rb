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

visited = []
accumulator = 0
index = 0

loop do
  instruction, value = PROGRAM[index].split

  if visited.include?(index)
    puts accumulator.to_s
    break
  end

  visited.push index

  if instruction == 'acc'
    accumulator += value.to_i
    index += 1
  elsif instruction == 'jmp'
    index += value.to_i
  elsif instruction == 'nop'
    index += 1
  end
end
