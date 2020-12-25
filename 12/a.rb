require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
F10
N3
F7
R90
F11
TEXT

INPUT = read_input
INSTRUCTIONS = INPUT.split "\n"

LEFT = {n: :w, w: :s, s: :e, e: :n}
RIGHT = {w: :n, s: :w, e: :s, n: :e}

facing = :e
directions = {e: 0, n: 0, w: 0, s: 0}

def turn_left(direction, degrees)
  (degrees / 90).times { direction = LEFT[direction] }
  direction
end

def turn_right(direction, degrees)
  (degrees / 90).times { direction = RIGHT[direction] }
  direction
end

INSTRUCTIONS.each do |instruction|
  action = instruction[0].downcase.to_sym
  amount = instruction[1..-1].to_i

  case action
  when :f
    directions[facing] += amount
  when :l
    facing = turn_left facing, amount
  when :r
    facing = turn_right facing, amount
  when :e, :n, :w, :s
    directions[action] += amount
  end
end

puts (directions[:n] - directions[:s]).abs + (directions[:e] - directions[:w]).abs
