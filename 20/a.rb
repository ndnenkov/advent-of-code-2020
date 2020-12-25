require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..

Tile 1171:
####...##.
#..##.#..#
##.#..#.#.
.###.####.
..###.####
.##....##.
.#...####.
#.##.####.
####..#...
.....##...

Tile 1427:
###.##.#..
.#..#.##..
.#.##.#..#
#.#.#.##.#
....#...##
...##..##.
...#.#####
.#.####.#.
..#..###.#
..##.#..#.

Tile 1489:
##.#.#....
..##...#..
.##..##...
..#...#...
#####...#.
#..#.#.#.#
...#.#.#..
##.#...##.
..##.##.##
###.##.#..

Tile 2473:
#....####.
#..#.##...
#.##..#...
######.#.#
.#...#.#.#
.#########
.###.#..#.
########.#
##...##.#.
..###.#.#.

Tile 2971:
..#.#....#
#...###...
#.#.###...
##.##..#..
.#####..##
.#..####.#
#..#.#..#.
..####.###
..#.#.###.
...#.#.#.#

Tile 2729:
...#.#.#.#
####.#....
..#.#.....
....#..#.#
.##..##.#.
.#.####...
####.#.#..
##.####...
##..#.##..
#.##...##.

Tile 3079:
#.#.#####.
.#..######
..#.......
######....
####.#..#.
.#...#.##.
#.#####.##
..#.###...
..#.......
..#.###...

TEXT

INPUT = read_input

class Tile
  def initialize(image)
    @image = image
  end

  def top
    @image.first.join
  end

  def bottom
    @image.last.join
  end

  def left
    @image.map(&:first).join
  end

  def right
    @image.map(&:last).join
  end

  def match?(other)
    sides = [top, bottom, left, right].flat_map { |side| [side, side.reverse] }
    other_sides = [other.top, other.bottom, other.left, other.right].flat_map do |side|
      [side, side.reverse]
    end

    !(sides & other_sides).empty?
  end
end

def parse(input)
  tiles = {}
  last_tile = []
  last_tile_number = nil

  input.split("\n").each do |row|
    if row.match(/^Tile/)
      last_tile_number = row.match(/\d+/).to_s.to_i
    elsif row.empty?
      tiles[last_tile_number] = Tile.new last_tile
      last_tile = []
    else
      last_tile.push row.chars
    end
  end
  tiles[last_tile_number] = Tile.new last_tile

  tiles
end

TILES = parse INPUT

corner_tile_numbers = TILES.select do |number, tile|
  (TILES.values - [tile]).count { |other_tile| tile.match?(other_tile) } == 2
end.keys

puts corner_tile_numbers.reduce(:*)
