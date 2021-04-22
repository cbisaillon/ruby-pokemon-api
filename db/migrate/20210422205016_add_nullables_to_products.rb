class AddNullablesToProducts < ActiveRecord::Migration[6.1]
  def change
    change_table :pokemons do |t|
      t.change_null "type_2_id", true
      t.change_null "number", false
      t.change_null "name", false
    end
  end
end
