# frozen_string_literal: true

class User < ApplicationRecord
  include Confirmable

  has_secure_password
  # Enable Google Authenticator
  acts_as_google_authenticated lookup_token: :mfa_secret, google_secret_column: :mfa_secret

  validates :email, presence: true, uniqueness: true, email: true
  validates :password, password: true, if: :password_digest_changed?

  after_save :update_mfa_secret, if: proc { mfa_enabled_previously_changed? }

  # Always remove white spaces and downcase email address
  normalizes :email, with: -> (email) { email.strip.downcase }

  scope :confirmed, -> { where.not(confirmed_at: nil) }

  def update_without_password(params, *options)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    update(params, *options)
  end

  # Defines the google_label used in the QR code for Google Authenticator
  def google_label
    "#{email} (SecureAuth)"
  end

  private

  # Updated the mfa_secret field when user updates their multi factor auth preference
  def update_mfa_secret
    if saved_change_to_attribute?(:mfa_enabled, from: false, to: true)
      self.set_google_secret
    elsif saved_change_to_attribute?(:mfa_enabled, from: true, to: false)
      self.clear_google_secret!
    end
  end
end
