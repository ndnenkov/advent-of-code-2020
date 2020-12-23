INPUT = '219748365'

# INPUT = '389125467'

cups = (INPUT.chars.map(&:to_i) + 10.upto(1_000_000).to_a).each_cons(2).map do |first, second|
  [first, {number: first, next_number: second}]
end.to_h
current_cup = cups.first.last
cups[1_000_000] = {number: 1_000_000, next_number: current_cup[:number]}

10_000_000.times do
  first_cup = cups[current_cup[:next_number]]
  second_cup = cups[first_cup[:next_number]]
  third_cup = cups[second_cup[:next_number]]

  current_cup[:next_number] = third_cup[:next_number]

  destination_number =
    current_cup[:number].pred.downto(1).chain(1_000_000.downto(current_cup[:number])).find do |number|
      [first_cup, second_cup, third_cup].none? { |cup| cup[:number] == number }
    end

  destination_cup = cups[destination_number]
  third_cup[:next_number] = destination_cup[:next_number]
  destination_cup[:next_number] = first_cup[:number]

  current_cup = cups[current_cup[:next_number]]
end

first_cup = cups[cups.dig(1, :next_number)]
second_cup = cups[first_cup[:next_number]]
puts first_cup[:number] * second_cup[:number]
