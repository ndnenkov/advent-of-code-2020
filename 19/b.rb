require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
42: 9 14 | 10 1
9: 14 27 | 1 26
10: 23 14 | 28 1
1: "a"
11: 42 31
5: 1 14 | 15 1
19: 14 1 | 14 14
12: 24 14 | 19 1
16: 15 1 | 14 14
31: 14 17 | 1 13
6: 14 14 | 1 14
2: 1 24 | 14 4
0: 8 11
13: 14 3 | 1 12
15: 1 | 14
17: 14 2 | 1 7
23: 25 1 | 22 14
28: 16 1
4: 1 1
20: 14 14 | 1 15
3: 5 14 | 16 1
27: 1 6 | 14 18
14: "b"
21: 14 1 | 1 14
25: 1 1 | 1 14
22: 14 14
8: 42
26: 14 22 | 1 20
18: 15 15
7: 14 5 | 1 21
24: 14 1

abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
bbabbbbaabaabba
babbbbaabbbbbabbbbbbaabaaabaaa
aaabbbbbbaaaabaababaabababbabaaabbababababaaa
bbbbbbbaaaabbbbaaabbabaaa
bbbababbbbaaaaaaaabbababaaababaabab
ababaaaaaabaaab
ababaaaaabbbaba
baabbaaaabbaaaababbaababb
abbbbabbbbaaaababbbbbbaaaababb
aaaaabbaabaaaaababaa
aaaabbaaaabbaaa
aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
babaaabbbaaabaababbaabababaaab
aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba
TEXT

INPUT = read_input

def parse(input)
  rows = input.split "\n"
  messages = rows.drop_while { |row| row != '' }.drop(1)
  rules = rows.take_while { |row| row.match?(/^\d/) }.map { |row| row.split(': ') }.to_h

  [messages, rules]
end

MESSAGES, rules = parse INPUT

# 8: 42     => 8: 42 | 42 8
# 11: 42 31 => 11: 42 31 | 42 11 31
rules['8'] = "(?<eight>42 | 42 \\g<eight>)"
rules['11'] = "(?<eleven>42 31 | 42 \\g<eleven> 31)"

remaining_rule_numbers = rules.keys
loop do
  remaining_rule_numbers.each do |rule_number|
    rule = rules[rule_number]

    next if rule.match?(/\d/)

    rules.each do |matching_rule_number, matching_rule|
      rules[matching_rule_number] = matching_rule.gsub(/\b#{rule_number}\b/, "(#{rule})")
    end

    remaining_rule_numbers.delete rule_number
  end

  break if remaining_rule_numbers.empty?
end

rules.each { |rule_number, rule| rules[rule_number] = rule.tr('" ', '') }

puts MESSAGES.count { |message| message.match?(/^(#{rules['0']})$/) }
