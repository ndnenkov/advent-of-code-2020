require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
TEXT

INPUT = read_input
TREE_MAP = INPUT.split("\n").map(&:chars)

x = 0
y = 0
tree_count = 0
while y < TREE_MAP.size do
  tree_count += 1 if TREE_MAP[y][x] == '#'
  x = (x + 3) % TREE_MAP.first.size
  y += 1
end

puts tree_count
