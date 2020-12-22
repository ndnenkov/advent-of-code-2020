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

def turn(p1_deck, p2_deck)
  p "#{p1_deck.size}x#{p2_deck.size}"
  p1_card = p1_deck.shift
  p2_card = p2_deck.shift

  if p1_card > p2_card
    p1_deck.push p1_card, p2_card
  else
    p2_deck.push p2_card, p1_card
  end
end

loop do
  turn P1_DECK, P2_DECK
  break if P1_DECK.empty? || P2_DECK.empty?
end

winning_deck = P1_DECK.empty? ? P2_DECK : P1_DECK

sum = 0
winning_deck.reverse.each_with_index do |card, index|
  sum += card * index.next
end
puts sum


















