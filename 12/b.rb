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

waypoint = {e: 10, n: 1}
directions = {e: 0, n: 0, w: 0, s: 0}

def turn_waypoint_left(waypoint, degrees)
  return waypoint if degrees.zero?

  directions = waypoint.keys.map { |direction| LEFT[direction] }
  distances = waypoint.values

  turn_waypoint_left directions.zip(distances).to_h, degrees - 90
end

def turn_waypoint_right(waypoint, degrees)
  return waypoint if degrees.zero?

  directions = waypoint.keys.map { |direction| RIGHT[direction] }
  distances = waypoint.values

  turn_waypoint_right directions.zip(distances).to_h, degrees - 90
end

INSTRUCTIONS.each do |instruction|
  action = instruction[0].downcase.to_sym
  amount = instruction[1..-1].to_i

  case action
  when :f
    waypoint.each { |direction, distance| directions[direction] += amount * distance }
  when :l
    waypoint = turn_waypoint_left waypoint, amount
  when :r
    waypoint = turn_waypoint_right waypoint, amount
  when :e, :n, :w, :s
    oposite_direction = LEFT[LEFT[action]]
    distance = waypoint[action].to_i - waypoint[oposite_direction].to_i + amount

    perpendicular_waypoint_attributes = waypoint.slice LEFT[action], RIGHT[action]
    parallel_waypoint_attributes =
      if distance.positive?
        {action => distance}
      else
        {oposite_direction => distance.abs}
      end

    waypoint = parallel_waypoint_attributes.merge perpendicular_waypoint_attributes
  end
end

puts (directions[:n] - directions[:s]).abs + (directions[:e] - directions[:w]).abs
