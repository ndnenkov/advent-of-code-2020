require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
FBFBBFFRLR
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL
TEXT

INPUT = read_input
BOARDING_PASSES = INPUT.split("\n")

puts BOARDING_PASSES.map { |pass| pass.tr('FBLR', '0101').to_i(2) }.max
