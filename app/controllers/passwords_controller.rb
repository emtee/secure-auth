# frozen_string_literal: true

class PasswordsController < ApplicationController
  before_action :authenticate_user!

  def edit; end

  def update
    if current_user.update(password_params)
      redirect_to edit_password_path, notice: t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # Ensure user enter's current password before allowing password update with password_challenge
  def password_params
    params.require(:user).permit(
      :password,
      :password_confirmation,
      :password_challenge
      ).with_defaults(password_challenge: "")
  end
end
