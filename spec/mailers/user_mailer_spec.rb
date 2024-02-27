# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  subject(:mail) { described_class.confirmation_instructions(user).deliver_now }

  describe "confirmation_instructions" do
    let(:user) { create(:user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Confirm your email address")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["support@secureauth.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("You can confirm your account email through the link below:")
      expect(mail.body.encoded).to include(confirm_with_token_url(confirmation_token: user.confirmation_token))
      expect(mail.body.encoded).to match("Thanks for joining and have a great day!")
    end
  end
end
