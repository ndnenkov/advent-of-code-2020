INIT_STATE = <<~TEXT.split("\n").map(&:chars)
....###.
#...####
##.#.###
..#.#...
##.#.#.#
#.######
..#..#.#
######.#
TEXT

# INIT_STATE = <<~TEXT.split("\n").map(&:chars)
# .#.
# ..#
# ###
# TEXT

STATE = {}

INIT_STATE.each_with_index do |row, rindex|
  row.each_with_index do |cell, cindex|
    STATE[[rindex, cindex, 0, 0]] = cell == '#'
  end
end

def tick(state)
  counts = {}
  ((minx, maxx), (miny, maxy), (minz, maxz), (minw, maxw)) = state.keys.transpose.map(&:minmax)
  minx -= 1
  miny -= 1
  minz -= 1
  minw -= 1
  maxx += 1
  maxy += 1
  maxz += 1
  maxw += 1

  (minx..maxx).to_a.product((miny..maxy).to_a, (minz..maxz).to_a, (minw..maxw).to_a).each do |x, y, z, w|
    [-1, 0, 1].product([-1, 0, 1], [-1, 0, 1], [-1, 0, 1]).each do |xoff, yoff, zoff, woff|
      next if xoff.zero? && yoff.zero? && zoff.zero? && woff.zero?

      counts[[x,y,z,w]] ||= 0
      counts[[x,y,z,w]] += 1 if state[[x+xoff, y+yoff, z+zoff,w+woff]]
    end
  end

  counts.each do |key, count|
    if state[key] && [2,3].include?(count)
      counts[key] = true
    elsif count == 3
      counts[key] = true
    else
      counts[key] = false
    end
  end

  counts
end

6.times do
  STATE = tick STATE
end

puts STATE.values.count(&:itself)




