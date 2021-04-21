class CreateTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :types do |t|
      t.string :type_name

      t.timestamps

      t.index :type_name, unique: true
    end
  end
end
