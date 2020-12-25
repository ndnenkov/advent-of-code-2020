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
  instruction.scan(/sw|se|nw|ne/).each do |direction|
    counts[direction.to_sym] += 1
  end

  coordinates = [counts[:sw] - counts[:ne], counts[:se] - counts[:nw]]
  square_grid[coordinates] = !square_grid[coordinates]
end

100.times do
  black_neighbours_counts = square_grid.keys.map { |coordinates| [coordinates, 0] }.to_h

  square_grid.each do |(x, y), black|
    next unless black

    [[1, 0], [0, 1], [-1, 1], [-1, 0], [0, -1], [1, -1]].each do |x_offset, y_offset|
      black_neighbours_counts[[x + x_offset, y + y_offset]] ||= 0
      black_neighbours_counts[[x + x_offset, y + y_offset]] += 1
    end
  end

  black_neighbours_counts.each do |coordinates, count|
    if square_grid[coordinates] && !count.between?(1, 2)
      square_grid[coordinates] = false
    elsif !square_grid[coordinates] && count == 2
      square_grid[coordinates] = true
    end
  end
end

puts square_grid.values.count(&:itself)
