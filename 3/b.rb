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

SLOPES = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]

encountered_trees =
  SLOPES.map do |x_slope, y_slope|
    x = 0
    y = 0
    tree_count = 0
    while y < TREE_MAP.size do
      tree_count += 1 if TREE_MAP[y][x] == '#'
      x = (x + x_slope) % TREE_MAP.first.size
      y += y_slope
    end

    tree_count
  end

puts encountered_trees.reduce(:*)
