require 'rails_helper'

RSpec.describe "Api::V1::Accounts", type: :request do
  describe "GET /index" do
    let (:super_user) { create(:user, :super_user) }
    let (:admin) { create(:user, :admin) }
    let (:final_user) { create(:user, :user) }

    context 'when super_user try to list empty accounts' do
      before do
        sign_in super_user
      end

      it 'should return no content' do
        get api_v1_accounts_path
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when admin try to list empty accounts' do
      before do
        sign_in admin
      end

      it 'should return no content' do
        get api_v1_accounts_path
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when final_user try to list empty accounts' do
      before do
        sign_in final_user
      end

      it 'should return 422 :unprocessable_entity' do
        get api_v1_accounts_path
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return no content' do
        get api_v1_accounts_path
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to index? this Symbol')
      end
    end

    context 'when super_user list accounts' do
      let!(:accounts) do
        create_list(:account, 3)
      end

      before do
        sign_in super_user
      end

      it 'should return 200 :ok' do
        get api_v1_accounts_path
        expect(response).to have_http_status(:ok)
      end

      it "should to be an instance of hash" do
        get api_v1_accounts_path
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body).to be_an_instance_of(Hash)
      end
    end

    context 'when admin list accounts' do
      let!(:accounts) do
        create_list(:account, 3)
      end

      before do
        sign_in admin
      end

      it 'should return 200 :ok' do
        get api_v1_accounts_path
        expect(response).to have_http_status(:ok)
      end

      it "should to be an instance of hash" do
        get api_v1_accounts_path
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body).to be_an_instance_of(Hash)
      end
    end
  end

  describe 'GET /show' do
    let (:super_user) { create(:user, :super_user) }
    let (:admin) { create(:user, :admin) }
    let (:final_user) { create(:user, :user) }

    context 'when super_user try to retrieve an account does not exist' do
      before do
        sign_in super_user
      end

      it 'should return status 422 :unprocessable_entity if account does not exist' do
        get "#{api_v1_accounts_path}/2"
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error if account does not exist' do
        get "#{api_v1_accounts_path}/2"
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq("Couldn't find Account with 'id'=2")
      end
    end

    context 'when admin try to retrieve an account does not exist' do
      before do
        sign_in admin
      end

      it 'should return status 422 :unprocessable_entity if account does not exist' do
        get "#{api_v1_accounts_path}/2"
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error if account does not exist' do
        get "#{api_v1_accounts_path}/2"
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq("Couldn't find Account with 'id'=2")
      end
    end

    context 'when super_user try to retrieve an account' do
      let (:account) { create(:account) }

      before do
        sign_in super_user
      end

      it 'should return status 200 :ok' do
        get "#{api_v1_accounts_path}/#{account.id}"
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
      end

      it 'should return the queried account' do
        get "#{api_v1_accounts_path}/#{account.id}"
        body = JSON.parse(response.body)
        expect(body['account']['id']).to eq(account.id)
      end
    end

    context 'when admin try to retrieve an account' do
      let (:account) { create(:account) }

      before do
        sign_in admin
      end

      it 'should return status 200 :ok' do
        get "#{api_v1_accounts_path}/#{account.id}"
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
      end

      it 'should return the queried account' do
        get "#{api_v1_accounts_path}/#{account.id}"
        body = JSON.parse(response.body)
        expect(body['account']['id']).to eq(account.id)
      end
    end

    context 'when final_user try to retrieve an account' do
      let (:account) { create(:account) }

      before do
        sign_in final_user
      end

      it 'should return 422 :unprocessable_entity' do
        get "#{api_v1_accounts_path}/#{account.id}"
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return no content' do
        get "#{api_v1_accounts_path}/#{account.id}"
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to show? this Symbol')
      end
    end
  end

  describe 'POST /create' do
    let (:super_user) { create(:user, :super_user) }
    let (:admin) { create(:user, :admin) }
    let (:final_user) { create(:user, :user) }

    context 'when super_user create an account' do
      before do
        sign_in super_user
      end

      it 'should return status 201 :created' do
        post api_v1_accounts_path, params: create_params
        expect(response).to have_http_status(:created)
      end

      it 'should return the account name' do
        post api_v1_accounts_path, params: create_params
        body = JSON.parse(response.body)
        expect(body['account']['name']).to eq('DAOS Water')
      end

      it 'should return status 422 :unprocessable_entity' do
        post api_v1_accounts_path, params: create_params_with_missign_attribute
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return error name' do
        post api_v1_accounts_path, params: create_params_with_missign_attribute
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('La validación falló: Name no puede estar en blanco')
      end
    end

    context 'when admin create an account' do
      before do
        sign_in admin
      end

      it 'should return status 201 :created' do
        post api_v1_accounts_path, params: create_params
        expect(response).to have_http_status(:created)
      end

      it 'should return the account name' do
        post api_v1_accounts_path, params: create_params
        body = JSON.parse(response.body)
        expect(body['account']['name']).to eq('DAOS Water')
      end

      it 'should return status 422 :unprocessable_entity' do
        post api_v1_accounts_path, params: create_params_with_missign_attribute
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return error name' do
        post api_v1_accounts_path, params: create_params_with_missign_attribute
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('La validación falló: Name no puede estar en blanco')
      end
    end

    context 'when final_user try to create an account' do
      before do
        sign_in final_user
      end

      it 'should return status 422 :unprocessable_entity' do
        post api_v1_accounts_path, params: create_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "should return message error" do
        post api_v1_accounts_path, params: create_params
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to create? this Symbol')
      end
    end
  end

  describe 'PUT /update' do
    let (:super_user) { create(:user, :super_user) }
    let (:admin) { create(:user, :admin) }
    let (:final_user) { create(:user, :user) }
    let (:account) { create(:account) }
    context 'when super_user update an account' do
      before do
        sign_in super_user
      end

      it "should return 200 :ok" do
        put "#{api_v1_accounts_path}/#{account.id}", params: update_params
        expect(response).to have_http_status(:ok)
      end

      it "should show attributes updated" do
        put "#{api_v1_accounts_path}/#{account.id}", params: update_params
        body = JSON.parse(response.body)
        expect(body['account']['client_name']).to eq('Luis Osnet')
      end
    end

    context 'when admin update an account' do
      before do
        sign_in admin
      end

      it "should return 200 :ok" do
        put "#{api_v1_accounts_path}/#{account.id}", params: update_params
        expect(response).to have_http_status(:ok)
      end

      it "should show attributes updated" do
        put "#{api_v1_accounts_path}/#{account.id}", params: update_params
        body = JSON.parse(response.body)
        expect(body['account']['client_name']).to eq('Luis Osnet')
      end
    end

    context 'when final_user update an account' do
      before do
        sign_in final_user
      end

      it "should return 422 :unprocessable_entity" do
        put "#{api_v1_accounts_path}/#{account.id}", params: update_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "should show attributes updated" do
        put "#{api_v1_accounts_path}/#{account.id}", params: update_params
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to update? this Symbol')
      end
    end
  end

  describe 'DELETE /delete' do
    let (:super_user) { create(:user, :super_user) }
    let (:admin) { create(:user, :admin) }
    let (:final_user) { create(:user, :user) }
    let (:account) { create(:account) }

    context 'when super_user delete an account' do
      before do
        sign_in super_user
      end

      it "should return 204 :no_content" do
        delete "#{api_v1_accounts_path}/#{account.id}"
        expect(response).to have_http_status(:no_content)
      end

      it "should return 422 :unprocessable_entity" do
        delete "#{api_v1_accounts_path}/2"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when admin delete an account' do
      before do
        sign_in admin
      end

      it "should return 204 :no_content" do
        delete "#{api_v1_accounts_path}/#{account.id}"
        expect(response).to have_http_status(:no_content)
      end

      it "should return 422 :unprocessable_entity" do
        delete "#{api_v1_accounts_path}/2"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when final_user delete an account' do
      before do
        sign_in final_user
      end

      it "should return 422 :unprocessable_entity" do
        delete "#{api_v1_accounts_path}/#{account.id}"
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "should return message error" do
        delete "#{api_v1_accounts_path}/2"
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to destroy? this Symbol')
      end
    end
  end

  def create_params
    {
      account: {
        name: "DAOS Water",
        client_name: "Anais Ziemann",
        owner: "Blair Purdy"
      }
    }
  end

  def create_params_with_missign_attribute
    {
      account: {
        client_name: "Anais Ziemann",
        owner: "Blair Purdy"
      }
    }
  end

  def update_params
    {
      account: {
        name: "DAOS Water",
        client_name: "Luis Osnet",
        owner: "Blair Purdy"
      }
    }
  end

end
