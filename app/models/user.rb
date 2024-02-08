# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, email: true
  validates :password, password: true

  # Always remove white spaces and downcase email address
  normalizes :email, with: -> (email) { email.strip.downcase }
end
