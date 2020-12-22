# Single regex solution for Advent of Code 2020, day 4, part 2
#  https://adventofcode.com/2020/day/4

PASSPORTS = <<~TEXT
  eyr:1972 cid:100
  hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

  iyr:2019
  hcl:#602927 eyr:1967 hgt:170cm
  ecl:grn pid:012533040 byr:1946

  hcl:dab227 iyr:2012
  ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

  hgt:59cm ecl:zzz
  eyr:2038 hcl:74454a iyr:2023
  pid:3556412378 byr:2007

  pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
  hcl:#623a2f

  eyr:2029 ecl:blu cid:129 byr:1989
  iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

  hcl:#888785
  hgt:164cm byr:2001 iyr:2015 cid:88
  pid:545766238 ecl:hzl
  eyr:2022

  iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
TEXT

# Readable
valid_passport = %r{
  (?<birth-year>      byr: (?:19[2-9]\d|200[0-2])                              \b){0}
  (?<issue-year>      iyr: (?:201\d|2020)                                      \b){0}
  (?<expiration-year> eyr: (?:202\d|2030)                                      \b){0}
  (?<height>          hgt: (?:\g<centimeter-measurement>|\g<inch-measurement>) \b){0}
    (?<centimeter-measurement> (?:1[5-8]\d|19[0-3])cm ){0}
    (?<inch-measurement>       (?:59|6\d|7[0-6])in    ){0}
  (?<hair-color>      hcl: \#[0-9a-f]{6}                                       \b){0}
  (?<eye-color>       ecl: (?:amb|blu|brn|gry|grn|hzl|oth)                     \b){0}
  (?<passport-id>     pid: \d{9}                                               \b){0}

  (?<many-fields> (?: (?:byr|iyr|eyr|hgt|hcl|ecl|pid|cid): \S+\s)* ){0}

  (?=\g<many-fields>\g<birth-year>)
  (?=\g<many-fields>\g<issue-year>)
  (?=\g<many-fields>\g<expiration-year>)
  (?=\g<many-fields>\g<height>)
  (?=\g<many-fields>\g<hair-color>)
  (?=\g<many-fields>\g<eye-color>)
  (?=\g<many-fields>\g<passport-id>)
  \g<many-fields>
}x

# One-liner
valid_passport = /(?=(?:(?:(?:byr|iyr|eyr|hgt|hcl|ecl|pid|cid):\S+\s)*)(?:byr:(?:19[2-9]\d|200[0-2])\b))(?=(?:(?:(?:byr|iyr|eyr|hgt|hcl|ecl|pid|cid):\S+\s)*)(?:iyr:(?:201\d|2020)\b))(?=(?:(?:(?:byr|iyr|eyr|hgt|hcl|ecl|pid|cid):\S+\s)*)(?:eyr:(?:202\d|2030)\b))(?=(?:(?:(?:byr|iyr|eyr|hgt|hcl|ecl|pid|cid):\S+\s)*)(?:hgt:(?:(?:(?:1[5-8]\d|19[0-3])cm)|(?:(?:59|6\d|7[0-6])in))\b))(?=(?:(?:(?:byr|iyr|eyr|hgt|hcl|ecl|pid|cid):\S+\s)*)(?:hcl:\#[0-9a-f]{6}\b))(?=(?:(?:(?:byr|iyr|eyr|hgt|hcl|ecl|pid|cid):\S+\s)*)(?:ecl:(?:amb|blu|brn|gry|grn|hzl|oth)\b))(?=(?:(?:(?:byr|iyr|eyr|hgt|hcl|ecl|pid|cid):\S+\s)*)(?:pid:\d{9}\b))(?:(?:(?:byr|iyr|eyr|hgt|hcl|ecl|pid|cid):\S+\s)*)/

puts PASSPORTS.gsub(valid_passport, '♡').count('♡')
