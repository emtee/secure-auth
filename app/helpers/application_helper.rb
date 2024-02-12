# frozen_string_literal: true

module ApplicationHelper

  # Generated a button to Enable/Disable Two-factor authentication for user
  def button_for_two_factor_auth
    if current_user.mfa_enabled?
      button_to "Disable Two-factor Authentication", user_path(current_user), method: :put, class: "button is-light"
    else
      button_to "Enable Two-factor Authentication", user_path(current_user), method: :put, class: "button is-primary"
    end
  end
end
