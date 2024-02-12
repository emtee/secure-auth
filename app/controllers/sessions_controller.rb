# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_mfa, only: [:destroy] # Skip checking MFA for signout action

  def new; end

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      sign_in(user)
      auth_notice = user.mfa_enabled? ? t(".proceed_with_mfa") : t(".success")
      redirect_to root_path, notice: auth_notice
    else
      flash.now[:alert] = t(".failure")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    redirect_to new_session_path, notice: t(".success")
  end
end
