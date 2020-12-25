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
  left_x = (0...x).to_a.reverse.find { |nx| generation[y][nx] != '.' }
  right_x = (x.next...generation.first.size).to_a.find { |nx| generation[y][nx] != '.' }

  top_y = (0...y).to_a.reverse.find { |ny| generation[ny][x] != '.' }
  bottom_y = (y.next...generation.size).to_a.find { |ny| generation[ny][x] != '.' }

  left = [left_x, y] if left_x
  right = [right_x, y] if right_x
  top = [x, top_y] if top_y
  bottom = [x, bottom_y] if bottom_y

  left_top = nil
  right_bottom = nil
  left_bottom = nil
  right_top = nil

  offset = 1
  loop do
    if generation.dig(y - offset, x - offset).nil? || y < offset || x < offset
      left_top ||= []
    elsif generation.dig(y - offset, x - offset) != '.'
      left_top ||= [x - offset, y - offset]
    end

    if generation.dig(y + offset, x + offset).nil?
      right_bottom ||= []
    elsif generation.dig(y + offset, x + offset) != '.'
      right_bottom ||= [x + offset, y + offset]
    end

    if generation.dig(y - offset, x + offset).nil? || y < offset
      right_top ||= []
    elsif generation.dig(y - offset, x + offset) != '.'
      right_top ||= [x + offset, y - offset]
    end

    if generation.dig(y + offset, x - offset).nil? || x < offset
      left_bottom ||= []
    elsif generation.dig(y + offset, x - offset) != '.'
      left_bottom ||= [x - offset, y + offset]
    end

    break if left_top && right_bottom && left_bottom && right_top

    offset += 1
  end

  [
    left_top,
    right_bottom,
    left_bottom,
    right_top,
    left,
    top,
    bottom,
    right,
  ].compact.reject(&:empty?).map { |nx, ny| generation[ny][nx] }
end

def run(generation)
  next_generation = copy generation

  generation.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      adjacent = adjacent generation, x, y
      if cell == 'L' && adjacent.count('#').zero?
        next_generation[y][x] = '#'
      elsif cell == '#' && adjacent.count('#') >= 5
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
