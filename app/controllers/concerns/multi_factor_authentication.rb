# frozen_string_literal: true

#
# The Authentication module is a reusable concern that provides
# multi factor authentication features for controllers.
#
module MultiFactorAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :verify_mfa, if: :user_mfa_enabled?
  end

  private

  # Verifies the presence and ownership of UserMfaSession for the current user
  # and redirects the user to the page where they can set up a new MFA token.
  def verify_mfa
    user_mfa_session = UserMfaSession.find
    if user_mfa_session.nil? || user_mfa_session.record != current_user
      redirect_to new_user_mfa_session_path, notice: t("sessions.create.proceed_with_mfa")
    end
  end

  def clear_mfa_session
    current_user.google_secret = nil
    current_user.save!

    UserMfaSession.destroy
  end

  # Checks if the signed in user has MFA enabled
  def user_mfa_enabled?
    user_signed_in? && current_user.mfa_enabled?
  end
end
