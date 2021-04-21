class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.integer :number
      t.string :name
      t.belongs_to :type_1, null: false, foreign_key: {to_table: :types}
      t.belongs_to :type_2, null: false, foreign_key: {to_table: :types}
      t.integer :total
      t.integer :hp
      t.integer :attack
      t.integer :defense
      t.integer :sp_attack
      t.integer :sp_defense
      t.integer :speed
      t.integer :generation
      t.boolean :is_legendary

      t.timestamps

      t.index :number, unique: true
    end
  end
end
