class ApplicationController < ActionController::Base
  include Authentication
  include MultiFactorAuthentication
end
