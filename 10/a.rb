WOLTAGES = <<~TEXT.split("\n").map(&:to_i)
118
14
98
154
71
127
38
50
36
132
66
121
65
26
119
46
2
140
95
133
15
40
32
137
45
155
156
97
145
44
153
96
104
58
149
75
72
57
76
56
143
11
138
37
9
82
62
17
88
33
5
10
134
114
23
111
81
21
103
126
18
8
43
108
120
16
146
110
144
124
67
79
59
89
87
131
80
139
31
115
107
53
68
130
101
22
125
83
92
30
39
102
47
109
152
1
29
86
TEXT

# WOLTAGES = <<~TEXT.split("\n").map(&:to_i)
# 16
# 10
# 15
# 5
# 1
# 11
# 7
# 19
# 6
# 12
# 4
# TEXT

ones = 1
twos = 0
threes = 1
WOLTAGES.sort.each_cons(2).map do |x, y|
  case y - x
  when 1
    then ones += 1
  when 2
    then twos += 1
  when 3
    then threes += 1
  end
end
puts threes * ones
puts "#{threes} x #{ones}"

