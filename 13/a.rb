NOTES = <<~TEXT.split("\n")
1000677
29,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,661,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,521,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,x,x,19
TEXT

# NOTES = <<~TEXT.split("\n")
# 939
# 7,13,x,x,59,x,31,19
# TEXT

timestamp = NOTES.first.to_i
bus_numbers = NOTES.last.split(',').reject {|x| x == 'x'}.map(&:to_i)

# p bus_numbers
# bus =
# bus_numbers.min do |num|
#   puts "#{num} : #{(timestamp - (timestamp / num + 1) * num).abs}"
#   (timestamp - (timestamp / num + 1) * num).abs
#   # res = timestamp / num
#   # puts res
#   # if res * num == timestamp
#   #   timestamp
#   # else
#   #   (res + 1) * num
#   # end
# end

buzz = 0
rezz = 210210200210210120210021021012012
bus_numbers.each do |num|
  # puts "#{num} : #{(timestamp - (timestamp / num + 1) * num).abs}"
  res = (timestamp - (timestamp / num + 1) * num).abs
  if rezz > res
    buzz = num
    rezz = res
  end
  # res = timestamp / num
  # puts res
  # if res * num == timestamp
  #   timestamp
  # else
  #   (res + 1) * num
  # end
end
p buzz
bus = buzz

wait_time = (timestamp - (timestamp / bus + 1) * bus).abs
puts wait_time

# p "#{bus} * (#{wait_time} - #{timestamp})"
puts bus * wait_time
