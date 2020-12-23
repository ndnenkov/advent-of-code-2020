NOTES = <<~TEXT.split("\n")
1000677
29,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,661,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,521,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,x,x,19
TEXT

# NOTES = <<~TEXT.split("\n")
# 939
# 7,13,x,x,59,x,31,19
# TEXT

busses = NOTES.last.split(',').map(&:to_i)

busses.each_with_index do |bus, index|
  puts "x ≡ #{(bus - index) % bus} (mod #{bus})" if bus.positive?
end

# x ≡ 0 (mod 29)
# x ≡ 22 (mod 41)
# x ≡ 632 (mod 661)
# x ≡ 10 (mod 13)
# x ≡ 8 (mod 17)
# x ≡ 17 (mod 23)
# x ≡ 461 (mod 521)
# x ≡ 8 (mod 37)
# x ≡ 16 (mod 19)

# https://en.wikipedia.org/wiki/Chinese_remainder_theorem
# https://www.dcode.fr/chinese-remainder

# x = 213890632230818
