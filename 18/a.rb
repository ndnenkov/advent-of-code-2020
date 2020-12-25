require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2
TEXT

INPUT = read_input
TASKS = INPUT.split "\n"

class Integer
  alias_method :add, :+
  alias_method :mult, :*
end

puts TASKS.sum { |task| eval task.reverse.gsub('+', '.add').gsub('*', '.mult').tr('()', ')(') }
