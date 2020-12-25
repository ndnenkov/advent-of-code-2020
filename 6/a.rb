require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
abc

a
b
c

ab
ac

a
a
a
a

b
TEXT

INPUT = read_input
ANSWERS = INPUT.split("\n\n")

puts ANSWERS.sum { |answer| answer.delete("\n").chars.uniq.count }
