require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
.#.
..#
###
TEXT

INPUT = read_input
INITIAL_STATE = INPUT.split("\n").map(&:chars)

state = {}

INITIAL_STATE.each_with_index do |row, row_index|
  row.each_with_index do |cell, column_index|
    state[[row_index, column_index, 0, 0]] = cell == '#'
  end
end

def cycle(state)
  (min_x, max_x), (min_y, max_y), (min_z, max_z), (min_w, max_w) =
    state.keys.transpose.map(&:minmax).map { |min, max| [min.pred, max.next] }

  counts = {}
  (min_x..max_x).to_a.product(
    (min_y..max_y).to_a,
    (min_z..max_z).to_a,
    (min_w..max_w).to_a,
  ).each do |x, y, z, w|
    [-1, 0, 1].product(
      [-1, 0, 1],
      [-1, 0, 1],
      [-1, 0, 1],
    ).each do |x_offset, y_offset, z_offset, w_offset|
      next if x_offset.zero? && y_offset.zero? && z_offset.zero? && w_offset.zero?

      counts[[x, y, z, w]] ||= 0
      if state[[x + x_offset, y + y_offset, z + z_offset, w + w_offset]]
        counts[[x, y, z, w]] += 1
      end
    end
  end

  counts.each do |key, count|
    if state[key] && [2, 3].include?(count)
      counts[key] = true
    elsif count == 3
      counts[key] = true
    else
      counts[key] = false
    end
  end

  counts
end

6.times { state = cycle state }

puts state.values.count(&:itself)
