# frozen_string_literal: true

#
# The Authentication module is a reusable concern that provides
# authentication features for controllers. It leverages ActiveSupport::Concern
# to include authentication methods into any controller that includes this module.
# This module primarily offers methods to manage user sessions, determine the current
# user's authentication state, and make authentication-related helper methods available
# in views for consistent access across the application.
#
module Authentication
  extend ActiveSupport::Concern

  included do
    # Make current_user and user_signed_in? available in views
    helper_method :current_user, :user_signed_in?
  end

  private

  # Sets the current attribute with authenticated user & sets session variable
  def sign_in(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  # Resets the Current attribute & session variable
  def sign_out
    Current.user = nil
    reset_session
  end

  # Returns the authenticated user or sets one based on session
  def current_user
    Current.user ||= authenticate_user_with_session
  end

  def authenticate_user_with_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
end
