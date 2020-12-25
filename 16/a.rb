require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12
TEXT

INPUT = read_input

def parse(input)
  tickets = input.split "\n"

  fields = tickets.take_while { |row| row != '' }.map do |row|
    name, ranges = row.split ': '

    [name, eval("[#{ranges.gsub('-', '..').gsub(' or', ',')}]")]
  end.to_h

  nearby = tickets.drop_while { |row| row != 'nearby tickets:' }.drop(1).map do |row|
    row.split(',').map(&:to_i)
  end

  [fields, nearby]
end

FIELDS, NEARBY = parse INPUT

scanning_error_rate =
  NEARBY.flatten.select do |number|
    FIELDS.values.flatten.none? { |field_range| field_range.include? number }
  end.sum

puts scanning_error_rate
