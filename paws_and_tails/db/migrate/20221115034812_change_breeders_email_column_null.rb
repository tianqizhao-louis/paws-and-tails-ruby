class ChangeBreedersEmailColumnNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :breeders, :email, false
  end
end
