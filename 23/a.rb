INPUT = '219748365'

# INPUT = '389125467'

cups = INPUT.chars.map(&:to_i)
current_cup = cups.first

cups_slice = lambda do |from_index|
  min_index = from_index.next % cups.size
  max_index = (from_index + 3) % cups.size

  if min_index > max_index
    cups[min_index..-1] + cups[0..max_index]
  else
    cups[min_index..max_index]
  end
end

step = 1
loop do
  break if step == 101

  current_index = cups.index(current_cup)
  aside_cups = cups_slice.(current_index)
  cups_in_play = cups - aside_cups

  search_from = (current_cup.pred.zero? || ((1..current_cup.pred).to_a - aside_cups).empty?) ? 9 : current_cup.pred
  destination_cup = (9.downto(1).to_a - aside_cups).find { |digit| digit <= search_from }
  destination_cup_index = cups_in_play.index(destination_cup)

  cups = cups_in_play.insert destination_cup_index.next, *aside_cups

  cups_cycle = cups.cycle

  new_cups = cups
  loop do
    new_cups = cups.size.times.map { cups_cycle.next }
    if new_cups.index(current_cup) == current_index
      break
    end

    cups_cycle.next
  end

  cups = new_cups

  current_cup = cups[current_index.next % cups.size]
  step += 1
end

cups_cycle = cups.cycle
without_one = cups
loop do
  without_one = cups.size.times.map { cups_cycle.next }
  if without_one.index(1).zero?
    break
  end

  cups_cycle.next
end

puts without_one[1..-1].join
