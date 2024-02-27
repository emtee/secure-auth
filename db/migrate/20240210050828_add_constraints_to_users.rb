# frozen_string_literal: true

class AddConstraintsToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :email, :string, null: false, default: ""
    change_column :users, :password_digest, :string, null: false, default: ""

    add_index :users, :email, unique: true
  end
end
