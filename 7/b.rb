require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
TEXT

INPUT = read_input

def parse(input)
  input.
    scan(/^(\w+ \w+ bag)s contain((?: (?:\d+ )?\w+ \w+ bags?,?)+)\.$/).
    map do |container, contents_description|
      contents = contents_description.split(', ').map(&:strip).map do |content|
        count = content.to_i
        bag_name = content.gsub(/^#{count} |s$/, '')

        [bag_name, count]
      end

      [container, contents]
    end.to_h
end

BAGS = parse INPUT

def sum(container)
  return 0 if container == 'no other bag'

  BAGS[container].sum { |content, count| count * sum(content) + count }
end

puts sum('shiny gold bag')
