require "csv"
require "set"
require "sqlite3"

# Load Rails
DIR = File.dirname(__FILE__)
require DIR + '/../config/environment'

pokemon_csv = File.read(DIR + "/../storage/pokemon.csv")
csv = CSV.parse(pokemon_csv, :headers => true)

types = Set[]

csv.each do |row|
  number = row[0]
  name = row[1]
  type1 = row[2]
  type2 = row[3]
  total = row[4]
  hp = row[5]
  attack = row[6]
  defense = row[7]
  sp_attack = row[8]
  sp_defense = row[9]
  speed = row[10]
  generation = row[11]
  is_legendary = row[12]

  # Create the types in the database
  type1_model = nil
  type2_model = nil

  if type1 != nil
    type1_model = Type.where(type_name: type1).first_or_create
  end

  if type2 != nil
    type2_model = Type.where(type_name: type2).first_or_create
  end

   Pokemon.where(number: number).first_or_create(
    :name => name,
    :type_1_id => type1_model&.id,
    :type_2_id => type2_model&.id,
    :total => total,
    :hp => hp,
    :attack => attack,
    :defense => defense,
    :sp_attack => sp_attack,
    :sp_defense => sp_defense,
    :speed => speed,
    :generation => generation,
    :is_legendary => is_legendary == "True"
  )

end

