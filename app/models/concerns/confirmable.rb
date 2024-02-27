# frozen_string_literal: true

module Confirmable
  extend ActiveSupport::Concern

  included do
    after_create :generate_confirmation_token!

    after_commit :send_confirmation_instructions, on: :create
  end

  # Verifies whether a user is confirmed or not
  def confirmed?
    !!confirmed_at
  end

  # Resets the confirmation token and sets the confirmed_at time for user
  def confirm!
    update(confirmed_at: Time.current, confirmation_token: nil)
  end

  # Generated a new token for the user
  def generate_confirmation_token!
    update(confirmation_token: SecureRandom.hex(20))
  end

  # Send confirmation instructions by email
  def send_confirmation_instructions
    unless confirmation_token
      generate_confirmation_token!
    end

    UserMailer.confirmation_instructions(self).deliver
  end
end
