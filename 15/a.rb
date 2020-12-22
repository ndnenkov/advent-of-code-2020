NUMBERS = <<~TEXT.strip.split(',').map(&:to_i)
10,16,6,0,1,17
TEXT

# NUMBERS = <<~TEXT.strip.split(',').map(&:to_i)
# 0,3,6
# TEXT

NUM_AGES = (NUMBERS - [NUMBERS.last]).each_with_index.map {|x, i| [x, i+1]}.to_h

turn = NUMBERS.size - 1# - 1
last = NUMBERS.last

puts NUM_AGES.keys
puts '=========='
loop do
  # puts "#{turn}: #{last} (#{NUM_AGES})"
  # break if turn == 2020
  break if turn == 2019
  # break if turn == 10
  turn += 1

  x = NUM_AGES[last]
  NUM_AGES[last] = turn
  if x
    # puts "(#{turn - x}) [#{NUM_AGES}] found #{last} = #{x}, setting last = #{turn} - #{x}"
    last = turn - x# - 1
  else
    # puts "(0) [#{NUM_AGES}] not found #{last} = #{x}, setting last = 0"
    last = 0
  end
  # puts last
  # puts '-------------' if last == 436
end

puts last