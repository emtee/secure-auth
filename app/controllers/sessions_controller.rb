# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :verify_mfa, only: [:destroy] # Skip checking MFA for signout action

  def new; end

  def create
    # Only authenticate users with confirmed accounts
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      if user.confirmed?
        sign_in(user)
        redirect_to root_path, notice: sign_in_notice_for(user)
      else
        flash.now[:alert] = t(".unconfirmed")
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = t(".failure")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    redirect_to new_session_path, notice: t(".success")
  end

  private

  def sign_in_notice_for(user)
    user.mfa_enabled? ? t(".proceed_with_mfa") : t(".success")
  end
end
