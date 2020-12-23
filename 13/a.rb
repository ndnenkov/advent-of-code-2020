NOTES = <<~TEXT.split("\n")
1000677
29,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,661,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,521,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,x,x,19
TEXT

# NOTES = <<~TEXT.split("\n")
# 939
# 7,13,x,x,59,x,31,19
# TEXT

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
