# frozen_string_literal: true

class ConfirmationsController < ApplicationController
  def show
    if user = User.find_by(confirmation_token: params[:confirmation_token])
      user.confirm!
      redirect_to new_session_path, notice: t(".success")
    else
      redirect_to new_session_path, alert: t(".failure")
    end
  end
end
