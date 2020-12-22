require 'set'

DECKS = <<~TEXT.split("\n")
Player 1:
10
39
16
32
5
46
47
45
48
26
36
27
24
37
49
25
30
13
23
1
9
3
31
14
4

Player 2:
2
15
29
41
11
21
8
44
38
19
12
20
40
17
22
35
34
42
50
6
33
7
18
28
43
TEXT

# DECKS = <<~TEXT.split("\n")
# Player 1:
# 9
# 2
# 6
# 3
# 1

# Player 2:
# 5
# 8
# 4
# 7
# 10
# TEXT

P1_DECK = DECKS.take_while {|x| x != ''}.drop(1).map(&:to_i)
P2_DECK = DECKS.drop_while {|x| x != 'Player 2:'}.drop(1).map(&:to_i)

def turn(p1_deck, p2_deck, p1_configurations = [].to_set, p2_configurations = [].to_set)
  if p1_deck.empty? || p2_deck.empty?
    return [p1_deck, p2_deck, [p1_deck, p2_deck].max_by(&:size)]
  end

  if p1_configurations.include?(p1_deck.hash) || p2_configurations.include?(p2_deck.hash)
    return [p1_deck, p2_deck, p1_deck]
  end

  new_p1_configurations = p1_configurations + [p1_deck.hash]
  new_p2_configurations = p2_configurations + [p2_deck.hash]

  p1_card, *p1_deck = p1_deck
  p2_card, *p2_deck = p2_deck

  if p1_card <= p1_deck.size && p2_card <= p2_deck.size
    sub_p1_deck, sub_p2_deck, sub_winner = turn p1_deck.take(p1_card), p2_deck.take(p2_card)
    if sub_p1_deck == sub_winner
      turn p1_deck + [p1_card, p2_card], p2_deck, new_p1_configurations, new_p2_configurations
    else
      turn p1_deck, p2_deck + [p2_card, p1_card], new_p1_configurations, new_p2_configurations
    end
  elsif p1_card > p2_card
    turn p1_deck + [p1_card, p2_card], p2_deck, new_p1_configurations, new_p2_configurations
  else
    turn p1_deck, p2_deck + [p2_card, p1_card], new_p1_configurations, new_p2_configurations
  end
end

p1_deck, p2_deck, winning_deck = turn P1_DECK, P2_DECK

sum = 0
winning_deck.reverse.each_with_index do |card, index|
  sum += card * index.next
end
puts sum


















