# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :verify_mfa

  def update
    if current_user.update(mfa_enabled: !current_user.mfa_enabled?)
      if current_user.mfa_enabled?
        current_user.set_google_secret
        redirect_to new_user_mfa_session_path, notice: t("sessions.create.proceed_with_mfa")
      else
        redirect_to root_path, notice: t(".success")
      end
    else
      redirect_to root_path, alert: t(".failure")
    end
  end

  private

  def user_params
    params.require(:user).permit(:mfa_enabled)
  end
end
