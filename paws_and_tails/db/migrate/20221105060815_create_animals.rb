class CreateAnimals < ActiveRecord::Migration[7.0]
  def change
    create_table :animals do |t|
      t.string :name, null: false
      t.string :animal_type, null: false
      t.string :breed, null: false
      t.decimal :price, null: false
      t.datetime :anticipated_birthday, null: false

      t.references :breeder, null: false, foreign_key: true

      t.timestamps
    end
  end
end
