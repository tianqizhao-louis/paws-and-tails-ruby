class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :from_user, null: false, foreign_key: { to_table: :users }
      t.references :to_user, null: false, foreign_key: { to_table: :users }
      t.string :content

      t.timestamps
    end
  end
end
