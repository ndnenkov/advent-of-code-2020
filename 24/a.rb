require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew
TEXT

INPUT = read_input
INSTRUCTIONS = INPUT.split "\n"

square_grid = {[0, 0] => false}
INSTRUCTIONS.each do |instruction|
  instruction = instruction.gsub(/(?<![sn])w/, 'nwsw').gsub(/(?<![sn])e/, 'sene')

  counts = {sw: 0, se: 0, nw: 0, ne: 0}
  path = instruction.scan(/sw|se|nw|ne/)
  path.each do |direction|
    counts[direction.to_sym] += 1
  end

  coordinates = [counts[:sw] - counts[:ne], counts[:se] - counts[:nw]]
  square_grid[coordinates] = !square_grid[coordinates]
end

puts square_grid.values.count(&:itself)
