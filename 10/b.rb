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

WOLTAGES = <<~TEXT.split("\n").map(&:to_i)
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
TEXT

WOLTAGES.sort!

WOLTAGES = [0] + WOLTAGES
PATHS = [1]
WOLTAGES.each_with_index do |wolt, index|
  indis = [index - 3, index - 2, index - 1].select {|i| i >= 0}.select {|i| wolt - WOLTAGES[i] <= 3}
  next if index.zero?
  PATHS[index] = indis.sum {|i| PATHS[i] }
end
p PATHS.last











