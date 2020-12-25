require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
TEXT

INPUT = read_input
PROGRAM = INPUT.split "\n"

memory = {}
ones_mask = nil
xes_mask = nil
PROGRAM.each do |instruction|
  if instruction.start_with?('mask =')
    mask = instruction.split(' = ').last
    ones_mask = mask.tr('X', '1').to_i(2)
    xy_mask = mask.tr('10', 'YY')

    x_indices = xy_mask.chars.each_with_index.select { |xy, _| xy == 'X' }.map(&:last)
    xes_mask =
      %w(1 0).repeated_permutation(xy_mask.count('X')).map do |bits|
        mask = xy_mask.dup
        bits.zip(x_indices).each { |bit, x_index| mask[x_index] = bit }

        {ones_mask: mask.tr('Y', '0').to_i(2), zeroes_mask: mask.tr('Y', '1').to_i(2)}
      end
  else
    index = instruction.match(/\d+(?=\])/).to_s.to_i
    value = instruction.split(' = ').last.to_i
    index |= ones_mask

    memory[index] = value
    xes_mask.each do |x_mask|
      memory[index & x_mask[:zeroes_mask] | x_mask[:ones_mask]] = value
    end
  end
end

puts memory.values.sum
