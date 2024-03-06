# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  let(:password) { "str0ngPa$$" }

  describe "GET #new" do
    it "returns a success response" do
      get new_session_path
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid credentials" do
      let!(:user) { create(:user, :confirmed, email: "user@example.com", password:) }

      it "signs in the user and redirects to root path" do
        post sessions_path, params: { email: "user@example.com", password: }
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(flash[:notice]).to eq(I18n.t("sessions.create.success"))
      end
    end

    context "with invalid credentials" do
      it "renders the new template with unprocessable entity status" do
        post sessions_path, params: { email: "invalid@example.com", password: "password" }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq(I18n.t("sessions.create.failure"))
      end
    end

    context "when user is unconfirmed" do
      let!(:user) { create(:user, email: "unconfirmed@example.com", password: ) }

      it "renders the new template with unprocessable entity status" do
        post sessions_path, params: { email: "unconfirmed@example.com", password: }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(flash[:alert]).to eq(I18n.t("sessions.create.unconfirmed"))
      end
    end
  end

  describe "DELETE #destroy" do
  let!(:user) { create(:user, :confirmed, email: "user@example.com", password:) }

  it "signs out the user and redirects to new session path" do
      allow_any_instance_of(SessionsController).to receive(:sign_out)

      delete session_path(user)
      expect(response).to redirect_to(new_session_path)
      follow_redirect!
      expect(flash[:notice]).to eq(I18n.t("sessions.destroy.success"))
    end
  end
end
