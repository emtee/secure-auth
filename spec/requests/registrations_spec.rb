# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistrationsController, type: :request do
  describe "GET #new" do
    it "renders the new template" do
      get new_registration_path
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    let(:password) { "str0ngPa$$" }

    context "with valid parameters" do
      it "creates a new user and redirects to root path" do
        expect {
          post registrations_path, params: { user: { email: "test@example.com", password:, password_confirmation: password } }
        }.to change(User, :count).by(1)

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(I18n.t("registrations.create.success"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new user and renders the new template" do
        expect {
          post registrations_path, params: { user: { email: "invalid_email", password:, password_confirmation: "" } }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
