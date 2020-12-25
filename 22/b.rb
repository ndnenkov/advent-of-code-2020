require 'set'
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

def turn(p1_deck, p2_deck, p1_configurations = Set.new, p2_configurations = Set.new)
  if p1_deck.empty? || p2_deck.empty?
    return [p1_deck, p2_deck, [p1_deck, p2_deck].max_by(&:size)]
  end

  if p1_configurations.include?(p1_deck.hash) || p2_configurations.include?(p2_deck.hash)
    return [p1_deck, p2_deck, p1_deck]
  end

  p1_configurations += [p1_deck.hash]
  p2_configurations += [p2_deck.hash]

  p1_card, *p1_deck = p1_deck
  p2_card, *p2_deck = p2_deck

  p1_wins = p1_card > p2_card
  if p1_card <= p1_deck.size && p2_card <= p2_deck.size
    sub_p1_deck, _, sub_winner = turn p1_deck.take(p1_card), p2_deck.take(p2_card)

    p1_wins = sub_p1_deck == sub_winner
  end

  if p1_wins
    turn p1_deck + [p1_card, p2_card], p2_deck, p1_configurations, p2_configurations
  else
    turn p1_deck, p2_deck + [p2_card, p1_card], p1_configurations, p2_configurations
  end
end

*, winning_deck = turn p1_deck, p2_deck

puts winning_deck.reverse.each_with_index.sum { |card, index| card * index.next }
