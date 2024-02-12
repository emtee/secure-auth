# frozen_string_literal: true

class AddMfaSecretToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :google_secret, :string
    add_column :users, :mfa_secret, :string
    add_column :users, :mfa_enabled, :boolean, default: false

    add_index :users, :mfa_secret
  end
end
