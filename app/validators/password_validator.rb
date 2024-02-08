# frozen_string_literal: true

class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid_password?(value)
      record.errors.add(attribute, :weak_password)
    end
  end

  private

  def valid_password?(value)
    value.present? && value.match?(/\A
      (?=.*\d)           # Must contain a digit
      (?=.*[a-z])        # Must contain a lowercase letter
      (?=.*[A-Z])        # Must contain an uppercase letter
      .{8,}              # Must be at least 8 characters long
    \z/x)
  end
end
