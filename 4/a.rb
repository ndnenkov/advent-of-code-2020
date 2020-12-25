require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
TEXT

INPUT = read_input
PASSPORTS = INPUT.split("\n\n")

FIELDS = %w(byr iyr eyr hgt hcl ecl pid)

passport_entries = PASSPORTS.map do |passport|
  passport.
    split(/\s/).
    reject(&:empty?).
    map { |field_with_value| field_with_value.split ':' }.
    to_h
end

valid_passports = passport_entries.count { |passport| (FIELDS - passport.keys.uniq).empty? }

puts valid_passports
