require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
TEXT

INPUT = read_input
PASSWORD_ENTRIES = INPUT.split "\n"

count =
  PASSWORD_ENTRIES.count do |password_entry|
    min, max, letter, password = password_entry.match(/(\d+)-(\d+) (\w): (\w+)/).captures
    password.count(letter).between? min.to_i, max.to_i
  end

puts count
