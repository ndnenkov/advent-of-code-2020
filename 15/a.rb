NUMBERS = <<~TEXT.strip.split(',').map(&:to_i)
10,16,6,0,1,17
TEXT

# NUMBERS = <<~TEXT.strip.split(',').map(&:to_i)
# 0,3,6
# TEXT

ages = NUMBERS[0...-1].map.with_index { |number, index| [number, index.next] }.to_h

turn = NUMBERS.size
last = NUMBERS.last

loop do
  break if turn == 2020

  last_age = ages[last]
  ages[last] = turn
  last = last_age ? turn - last_age : 0

  turn += 1
end

puts last
