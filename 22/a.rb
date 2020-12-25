require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10
TEXT

INPUT = read_input
DECKS = INPUT.split "\n"

p1_deck = DECKS.take_while { |row| row != '' }.drop(1).map(&:to_i)
p2_deck = DECKS.drop_while { |row| row != 'Player 2:' }.drop(1).map(&:to_i)

def turn(p1_deck, p2_deck)
  p1_card = p1_deck.shift
  p2_card = p2_deck.shift

  if p1_card > p2_card
    p1_deck.push p1_card, p2_card
  else
    p2_deck.push p2_card, p1_card
  end
end

loop do
  turn p1_deck, p2_deck

  break if p1_deck.empty? || p2_deck.empty?
end

winning_deck = p1_deck.empty? ? p2_deck : p1_deck

puts winning_deck.reverse.each_with_index.sum { |card, index| card * index.next }
