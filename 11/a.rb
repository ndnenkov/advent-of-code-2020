require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
TEXT

INPUT = read_input
MAP = INPUT.split("\n").map(&:chars)

def copy(generation)
  Marshal.load Marshal.dump(generation)
end

def adjacent(generation, x, y)
  xes = [x - 1, x, x + 1].reject(&:negative?).reject { |x| x >= generation.first.size }
  ys = [y - 1, y, y + 1].reject(&:negative?).reject { |y| y >= generation.size }

  xes.product(ys).reject do |neighbour_x, neighbour_y|
    (neighbour_x == x && neighbour_y == y) || (generation[neighbour_y][neighbour_x] == '.')
  end.map { |neighbour_x, neighbour_y| generation[neighbour_y][neighbour_x] }
end

def run(generation)
  next_generation = copy generation

  generation.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      adjacent = adjacent generation, x, y
      if cell == 'L' && adjacent.count('#').zero?
        next_generation[y][x] = '#'
      elsif cell == '#' && adjacent.count('#') >= 4
        next_generation[y][x] = 'L'
      end
    end
  end

  if next_generation == generation
    next_generation.flatten.count('#')
  else
    run next_generation
  end
end

puts run(MAP)
