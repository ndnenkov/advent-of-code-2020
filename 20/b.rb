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
  attr_reader :image

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

  def to_s
    @image.map(&:join).join("\n")
  end

  def match?(other)
    return true unless other

    sides = [top, bottom, left, right].flat_map { |side| [side, side.reverse] }
    other_sides = [other.top, other.bottom, other.left, other.right].flat_map do |side|
      [side, side.reverse]
    end

    !(sides & other_sides).empty?
  end

  def oriented_towards(top_tile, left_tile)
    all_variations.select do |variation|
      [nil, variation.top].include?(top_tile&.bottom) &&
        [nil, variation.left].include?(left_tile&.right)
    end
  end

  def all_variations
    [false, true].product([0, 90, 180, 270]).map do |flip, rotation|
      dup.reorient flip: flip, rotation: rotation
    end
  end

  def reorient(flip: false, rotation: 0)
    @image = @image.map(&:reverse) if flip
    rotate rotation
  end

  private

  def rotate(degrees)
    return self if degrees.zero?

    @image = @image.transpose

    reorient flip: true

    rotate degrees - 90
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

def order_without_orientation(fixed, remaining, size)
  return fixed if remaining.empty?

  top_tile = fixed.size < size ? nil : fixed[fixed.size - size]
  left_tile = (fixed.size % size).zero? ? nil : fixed.last

  pick_from = remaining.select { |tile| tile.match?(top_tile) && tile.match?(left_tile) }

  pick_from.find do |tile|
    order = order_without_orientation fixed + [tile], remaining - [tile], size
    return order if order
  end
end

def correct_orientation(fixed, remaining, size)
  return fixed if remaining.empty?

  current_tile, *remaining = remaining

  top_tile = fixed.size < size ? nil : fixed[fixed.size - size]
  left_tile = (fixed.size % size).zero? ? nil : fixed.last

  current_tile.oriented_towards(top_tile, left_tile).find do |flipped|
    orientation = correct_orientation fixed + [flipped], remaining, size
    return orientation if orientation
  end
end

TILES = parse INPUT
SQUARE_SIZE = (TILES.size ** 0.5).to_i

corner_tile = TILES.find do |number, tile|
  (TILES.values - [tile]).count { |other_tile| tile.match?(other_tile) } == 2
end.last

without_orientation = order_without_orientation(
  [corner_tile],
  TILES.values - [corner_tile],
  SQUARE_SIZE,
)
with_orientation = correct_orientation [], without_orientation, SQUARE_SIZE

complete_image = ''
with_orientation.each_slice(SQUARE_SIZE).each do |satelite_row|
  images = satelite_row.map(&:image)

  (1...9).each do |row_index|
    complete_image += images.map { |image| image[row_index][1...-1].join }.join
    complete_image += "\n"
  end
end

def monster_pattern(lead)
  # lead|                  #
  # lead|#    ##    ##    ###
  # lead| #  #  #  #  #  #
  /#(..*\n.{#{lead}})#(.{4})##(.{4})##(.{4})###(.*\n..{#{lead}})#(.{2})#(.{2})#(.{2})#(.{2})#(.{2})#/
end

line_size = complete_image.match(/.+/).to_s.size
complete_image_with_orientation =
  Tile.new(complete_image.split.map(&:chars)).all_variations.find do |variation|
    as_string = variation.to_s

    0.upto(line_size.pred).find { |size| as_string.match monster_pattern(size) }
  end.to_s

0.upto(line_size.pred).each do |leading_size|
  complete_image_with_orientation.gsub!(monster_pattern(leading_size)) do
    "🐉#{$1}🐉#{$2}🐉🐉#{$3}🐉🐉#{$4}🐉🐉🐉#{$5}🐉#{$6}🐉#{$7}🐉#{$8}🐉#{$9}🐉#{$10}🐉"
  end
end

puts complete_image_with_orientation.count('#')
