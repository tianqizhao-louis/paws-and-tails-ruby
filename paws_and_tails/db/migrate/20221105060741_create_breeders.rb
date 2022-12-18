class CreateBreeders < ActiveRecord::Migration[7.0]
  def change
    create_table :breeders do |t|
      t.string :name, null: false
      t.string :city, null: false
      t.string :country, null: false
      t.string :price_level, null: false
      t.text :address, null: false

      t.timestamps
    end
  end
end
