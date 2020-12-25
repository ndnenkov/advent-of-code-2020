require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
939
7,13,x,x,59,x,31,19
TEXT

INPUT = read_input
NOTES = INPUT.split "\n"

timestamp = NOTES.first.to_i
busses = NOTES.last.split(',').difference(%w(x)).map(&:to_i)

earliest_bus = nil
earliest_bus_wait_time = Float::INFINITY
busses.each do |bus|
  wait_time = (timestamp - (timestamp / bus + 1) * bus).abs

  if earliest_bus_wait_time > wait_time
    earliest_bus = bus
    earliest_bus_wait_time = wait_time
  end
end

puts earliest_bus * earliest_bus_wait_time
