require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
TEXT

INPUT = read_input
PREAMBLE_SIZE = INPUT == SAMPLE_INPUT ? 5 : 25
NUMBERS = INPUT.split("\n").map(&:to_i)

index = 0
preamble = NUMBERS.take(PREAMBLE_SIZE).combination(2).map(&:sum)
number =
  NUMBERS.drop(PREAMBLE_SIZE).find do |number|
    if preamble.include?(number)
      index += 1
      until_index = [index + PREAMBLE_SIZE, NUMBERS.size].min
      preamble = NUMBERS[index...until_index].combination(2).map(&:sum)
      next
    end

    number
  end

2.upto(NUMBERS.size).find do |size|
  slice = NUMBERS.each_cons(size).lazy.find { |slice| slice.sum == number }

  if slice
    puts slice.minmax.sum
    break
  end
end
