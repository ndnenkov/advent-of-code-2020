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

agreement_counts_sum = ANSWERS.sum do |answer|
  answer.split("\n").map { |person_answer| person_answer.chars.uniq }.reduce(:&).size
end

puts agreement_counts_sum
