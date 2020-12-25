require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
5764801
17807724
TEXT

INPUT = read_input

card_public_key, door_public_key = INPUT.split.map(&:to_i)

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
