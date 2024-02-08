# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value("user@example.com").for(:email) }
    it { should_not allow_value("invalid_email").for(:email).with_message("is not a valid email") }
    it { should allow_value("Str0ngPa$$").for(:password) }
    it { should_not allow_value("weak").for(:password) }
  end
end
