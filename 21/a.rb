require_relative '../read_input'

SAMPLE_INPUT = <<~TEXT
mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)
TEXT

INPUT = read_input

def parse(input)
  foods = []
  possible_relations = {}
  input.split("\n").each_with_index do |row, index|
    ingredients, alergens = row.tr(')', '').split('(contains ')
    ingredients = ingredients.split
    alergens = alergens.split(', ')

    foods.push ingredients: ingredients, alergens: alergens

    alergens.each do |alergen|
      possible_relations[alergen] ||= ingredients
      possible_relations[alergen] &= ingredients
    end
  end

  [foods, possible_relations]
end

FOODS, POSSIBLE_RELATIONS = parse INPUT

def correct?(ingredient_alergen_guesses)
  FOODS.all? do |ingredients:, alergens:|
    alergens_to_remove = ingredient_alergen_guesses.select do |ingredient, _|
      ingredients.include? ingredient
    end.values

    (alergens - alergens_to_remove).empty?
  end
end

def find_mapping(remaining_alergens, ingredient_alergen_guesses = {})
  if remaining_alergens.empty? && correct?(ingredient_alergen_guesses)
    return ingredient_alergen_guesses
  end

  remaining_alergens.find do |alergen|
    POSSIBLE_RELATIONS[alergen].find do |possible_ingredient|
      next if ingredient_alergen_guesses[possible_ingredient]

      mapping = find_mapping(
        remaining_alergens - [alergen],
        ingredient_alergen_guesses.merge(possible_ingredient => alergen),
      )
      return mapping if mapping
    end
  end
end

ingredients_with_alergens = find_mapping(POSSIBLE_RELATIONS.keys).keys
puts FOODS.flat_map { |food| food[:ingredients] - ingredients_with_alergens }.size
