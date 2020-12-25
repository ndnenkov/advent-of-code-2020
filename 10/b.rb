require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
TEXT

INPUT = read_input
JOLTAGES = INPUT.split("\n").map(&:to_i)

joltage_chain = [0] + JOLTAGES.sort
arrangement_counts = [1]

joltage_chain.each_with_index do |joltage, index|
  next if index.zero?

  candidate_indices =
    [index - 3, index - 2, index - 1].
      reject(&:negative?).
      select { |index| joltage - joltage_chain[index] <= 3 }

  arrangement_counts[index] = candidate_indices.sum { |index| arrangement_counts[index] }
end

puts arrangement_counts.last
