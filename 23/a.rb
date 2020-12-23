INPUT = '219748365'

# INPUT = '389125467'

cups = INPUT.chars.map(&:to_i).each_cons(2).map do |first, second|
  [first, {number: first, next_number: second}]
end.to_h
current_cup = cups.first.last
cups[INPUT[-1].to_i] = {number: INPUT[-1].to_i, next_number: current_cup[:number]}

100.times do
  first_cup = cups[current_cup[:next_number]]
  second_cup = cups[first_cup[:next_number]]
  third_cup = cups[second_cup[:next_number]]

  current_cup[:next_number] = third_cup[:next_number]

  destination_number =
    current_cup[:number].pred.downto(1).chain(9.downto(current_cup[:number])).find do |number|
      [first_cup, second_cup, third_cup].none? { |cup| cup[:number] == number }
    end

  destination_cup = cups[destination_number]
  third_cup[:next_number] = destination_cup[:next_number]
  destination_cup[:next_number] = first_cup[:number]

  current_cup = cups[current_cup[:next_number]]
end

cups_after_one = ''
current_cup = cups[1]
8.times do
  current_cup = cups[current_cup[:next_number]]
  cups_after_one += current_cup[:number].to_s
end

puts cups_after_one
