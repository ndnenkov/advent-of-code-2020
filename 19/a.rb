require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
0: 4 1 5
1: 2 3 | 3 2
2: 4 4 | 5 5
3: 4 5 | 5 4
4: "a"
5: "b"

ababbb
bababa
abbbab
aaabbb
aaaabbb
TEXT

INPUT = read_input

def parse(input)
  rows = input.split "\n"
  messages = rows.drop_while { |row| row != '' }.drop(1)
  rules = rows.take_while { |row| row.match?(/^\d/) }.map { |row| row.split(': ') }.to_h

  [messages, rules]
end

MESSAGES, rules = parse INPUT

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
