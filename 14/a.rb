require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
TEXT

INPUT = read_input
PROGRAM = INPUT.split "\n"

memory = {}
ones_mask = nil
zeroes_mask = nil
PROGRAM.each do |instruction|
  if instruction.start_with?('mask =')
    mask = instruction.split(' = ').last
    ones_mask = mask.tr('X', '0').to_i(2)
    zeroes_mask = mask.tr('X', '1').to_i(2)
  else
    index = instruction.match(/\d+(?=\])/).to_s.to_i
    value = instruction.split(' = ').last.to_i

    memory[index] = value & zeroes_mask | ones_mask
  end
end

puts memory.values.sum
