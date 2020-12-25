require_relative '../read_input'

INPUT = read_input
BOARDING_PASSES = INPUT.split("\n")

seat_ids = BOARDING_PASSES.map { |pass| pass.tr('FBLR', '0101').to_i(2) }
lookup_range = 1.upto(1023).to_a - seat_ids
seat_id = lookup_range.find { |seat_id| ([seat_id + 1, seat_id - 1] - seat_ids).empty? }

puts seat_id
