require 'rails_helper'

RSpec.describe "Api::V1::Sessions::Authentication", type: :request do
  describe User do
    let (:super_user) { create(:user, :super_user) }
    let (:admin) { create(:user, :admin, password: '123456') }
    let (:user) { create(:user, :user) }
    let(:login_url) { '/api/v1/login' }
    let(:logout_url) { '/api/v1/logout' }

    context "when login as user" do
      it 'super_user should returns 200' do
        post login_url, params: {
          user: {
            email: super_user.email,
            password: super_user.password
          }
        }
        expect(response).to have_http_status(:ok)
      end

      it 'admin should returns 200' do
        post login_url, params: {
          user: {
            email: admin.email,
            password: admin.password
          }
        }
        expect(response).to have_http_status(:ok)
      end

      it 'user should returns 200' do
        post login_url, params: {
          user: {
            email: user.email,
            password: user.password
          }
        }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when login as user" do
      it 'super_user should returns 401' do
        post login_url, params: {
          user: {
            email: super_user.email,
            password: 'wrong_password'
          }
        }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'admin should returns 401' do
        post login_url, params: {
          user: {
            email: admin.email,
            password: 'wrong_password'
          }
        }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'user should returns 401' do
        post login_url, params: {
          user: {
            email: user.email,
            password: 'wrong_password'
          }
        }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when logout' do
      before do
        delete logout_url, params: {
          app_user: {
            email: user.email,
            password: user.password
          }
        }
      end

      it 'response no content' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
