# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    if user = User.authenticate_by(email: params[:email], password: params[:password])
      sign_in(user)
      redirect_to root_path, notice: t(".success")
    else
      flash.now[:alert] = t(".failure")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: t(".success")
  end
end
