class Addmodelcolumnsforuser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :password_digest, :string
    add_column :users, :api_token, :string
  end
end
