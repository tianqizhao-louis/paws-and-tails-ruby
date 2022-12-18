class ChangeUserColumns < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :user_name, false
    change_column_null :users, :password_digest, false
    change_column_null :users, :user_type, false
  end
end
