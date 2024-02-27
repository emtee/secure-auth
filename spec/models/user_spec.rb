# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "validations" do
    it { should be_valid }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should allow_value("user@example.com").for(:email) }
    it { should_not allow_value("invalid_email").for(:email).with_message("is not a valid email") }
    it { should allow_value("Str0ngPa$$").for(:password) }
    it { should_not allow_value("weak").for(:password) }

    context "when password_digest has changed" do
      it 'validates the password with custom rules when password is being set' do
        user = build(:user, password: nil, password_confirmation: nil) # Assuming the factory sets a valid password by default
        user.password = 'Str0ngPa$$'
        user.password_confirmation = 'Str0ngPa$$'
        expect(user).to be_valid
      end

      it 'is invalid with a weak password' do
        user = build(:user, password: nil, password_confirmation: nil) # Clearing default password
        user.password = 'weak'
        user.password_confirmation = 'weak'
        user.valid? # Trigger validations
        expect(user.errors[:password]).to include('must include at least one lowercase letter, one uppercase letter, one digit, and one symbol, and be at least 8 characters long')
      end
    end

    context "when password_digest has not changed" do
      it 'does not validate the password with custom rules when password is not being updated' do
        user = create(:user) # Persist a user with a valid password
        user.email = 'new@example.com' # Change an attribute other than password
        expect(user).to be_valid
      end
    end
  end

  describe "callbacks" do
    context "when two-factor authentication is enabled" do
      let(:user) { create(:user, mfa_enabled: false) }

      it "sets mfa_secret" do
        user.update(mfa_enabled: true)
        expect(user.mfa_secret).not_to be_nil
      end
    end

    context "when two-factor authentication is disabled" do
      let(:user) { create(:user, mfa_enabled: true) }

      it "resets mfa_secret to nil" do
        user.update(mfa_enabled: false)
        expect(user.mfa_secret).to be_nil
      end
    end
  end

  describe "confirmed scope" do
    let(:confirmed_user) { create(:user, confirmed_at: Time.current) }
    let(:unconfirmed_user) { create(:user) }

    it "includes only confirmed users" do
      expect(User.confirmed).to eq([confirmed_user])
      expect(User.confirmed).not_to eq([unconfirmed_user])
    end
  end
end
