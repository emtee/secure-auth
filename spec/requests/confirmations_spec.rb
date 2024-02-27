require 'rails_helper'

RSpec.describe ConfirmationsController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user, confirmation_token: 'abc123') }

    context 'with valid confirmation token' do
      before { get :show, params: { confirmation_token: user.confirmation_token } }

      it 'confirms the user' do
        user.reload
        expect(user.confirmed_at).not_to be_nil
      end

      it 'redirects to the new session path with a success notice' do
        expect(response).to redirect_to(new_session_path)
        expect(flash[:notice]).to eq(I18n.t('confirmations.show.success'))
      end
    end

    context 'with invalid confirmation token' do
      before { get :show, params: { confirmation_token: 'invalid_token' } }

      it 'redirects to the new session path with a failure alert' do
        expect(response).to redirect_to(new_session_path)
        expect(flash[:alert]).to eq(I18n.t('confirmations.show.failure'))
      end
    end
  end
end
