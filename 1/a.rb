require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
1721
979
366
299
675
1456
TEXT

INPUT = read_input
AMOUNTS = INPUT.split.map(&:to_i)

puts AMOUNTS.combination(2).lazy.find { |x, y| x + y == 2020 }.reduce(:*)
