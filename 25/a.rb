INPUT = <<~TEXT.split("\n")
8458505
16050997
TEXT

# INPUT = <<~TEXT.split("\n")
# 5764801
# 17807724
# TEXT

card_public_key, door_public_key = INPUT.map(&:to_i)

current = 1
door_loop = 1
loop do
  current = (current * 7) % 20201227

  break if current == door_public_key

  door_loop += 1
end

current = 1
door_loop.times { current = (current * card_public_key) % 20201227 }

puts current
