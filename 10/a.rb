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

ones = 1
threes = 1
JOLTAGES.sort.each_cons(2).map do |first_joltage, second_joltage|
  case second_joltage - first_joltage
  when 1 then ones += 1
  when 3 then threes += 1
  end
end

puts threes * ones
