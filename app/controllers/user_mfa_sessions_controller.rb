# frozen_string_literal: true

class UserMfaSessionsController < ApplicationController
  skip_before_action :verify_mfa, only: [:new, :create]

  def new; end

  def create
    user = current_user

    if user.update_without_password(user_params) && user.google_authentic?(params[:google_secret])
      UserMfaSession.create(user)
      redirect_to root_path, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new
    end
  end

  private

  def user_params
    params.permit(:google_secret)
  end
end

