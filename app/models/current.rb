# frozen_string_literal: true

#
# Abstract super class that provides a thread-isolated attributes singleton,
# which resets automatically before and after each request.
#
class Current < ActiveSupport::CurrentAttributes
  attribute :user
end
