# frozen_string_literal: true

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.is_a?(String) && value =~ URI::MailTo::EMAIL_REGEXP
      record.errors.add(attribute, :invalid_email)
    end
  end
end
