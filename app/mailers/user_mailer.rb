# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def confirmation_instructions(user)
    @user = user
    mail(to: @user.email, subject: 'Confirm your email address')
  end
end
