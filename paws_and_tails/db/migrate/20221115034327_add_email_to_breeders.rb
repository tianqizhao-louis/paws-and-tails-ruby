class AddEmailToBreeders < ActiveRecord::Migration[7.0]
  def change
    add_column :breeders, :email, :string
  end
end
