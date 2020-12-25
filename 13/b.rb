require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
939
7,13,x,x,59,x,31,19
TEXT

INPUT = read_input
NOTES = INPUT.split "\n"

busses = NOTES.last.split(',').map(&:to_i)

busses.each_with_index do |bus, index|
  puts "x ≡ #{(bus - index) % bus} (mod #{bus})" if bus.positive?
end

puts '--------------'
puts 'https://en.wikipedia.org/wiki/Chinese_remainder_theorem'
puts 'https://www.dcode.fr/chinese-remainder'

# x ≡ 0 (mod 29)
# x ≡ 22 (mod 41)
# x ≡ 632 (mod 661)
# x ≡ 10 (mod 13)
# x ≡ 8 (mod 17)
# x ≡ 17 (mod 23)
# x ≡ 461 (mod 521)
# x ≡ 8 (mod 37)
# x ≡ 16 (mod 19)

# x = 213890632230818
