require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9
TEXT

INPUT = read_input

def parse(input)
  tickets = input.split "\n"

  fields = tickets.take_while { |row| row != '' }.map do |row|
    name, ranges = row.split ': '

    [name, eval("[#{ranges.gsub('-', '..').gsub(' or', ',')}]")]
  end.to_h

  my_ticket =
    tickets.drop_while { |row| row != 'your ticket:' }.drop(1).first.split(',').map(&:to_i)

  nearby = tickets.drop_while { |row| row != 'nearby tickets:' }.drop(1).map do |row|
    row.split(',').map(&:to_i)
  end

  [fields, my_ticket, nearby]
end

FIELDS, MY_TICKET, NEARBY = parse INPUT

valid_nearby = NEARBY.select do |tickets|
  tickets.all? do |ticket|
    FIELDS.values.flatten.any? { |field_range| field_range.include? ticket }
  end
end

field_guesses = FIELDS.keys.map { |field| [field, (0...MY_TICKET.size).to_a] }.to_h
valid_nearby.each do |tickets|
  tickets.each_with_index do |ticket, index|
    FIELDS.each do |name, ranges|
      next if ranges.any? { |range| range.include? ticket }

      field_guesses[name].delete index
    end
  end
end

loop do
  sure_guesses = field_guesses.values.select { |numbers| numbers.size == 1 }.flatten

  field_guesses.each do |name, numbers|
    next if numbers.size == 1

    field_guesses[name] = numbers - sure_guesses
  end

  break if field_guesses.values.all? { |numbers| numbers.size == 1 }
end

product = 1
field_guesses.each do |name, numbers|
  next unless name.start_with? 'departure'

  product *= MY_TICKET[numbers.first]
end

puts product
