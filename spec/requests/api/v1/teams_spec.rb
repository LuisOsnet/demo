# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Teams', type: :request do
  describe 'GET /index' do
    let(:super_user) { create(:user, :super_user) }
    let(:admin) { create(:user, :admin) }
    let(:final_user) { create(:user, :user) }

    context 'when super_user try to list empty teams' do
      before do
        sign_in super_user
      end

      it 'should return no content' do
        get api_v1_teams_path
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when admin try to list empty teams' do
      before do
        sign_in admin
      end

      it 'should return no content' do
        get api_v1_teams_path
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when final_user try to list empty teams' do
      before do
        sign_in final_user
      end

      it 'should return error 422 :unprocessable_entity' do
        get api_v1_teams_path
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error' do
        get api_v1_teams_path
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to index? this Symbol')
      end
    end

    context 'when super_user list teams' do
      let(:account) { create(:account) }

      let!(:team) do
        create_list(:team, 3, account_id: account.id)
      end

      before do
        sign_in super_user
      end

      it 'should return 200 :ok' do
        get api_v1_teams_path
        expect(response).to have_http_status(:ok)
      end

      it 'should to be an instance of hash' do
        get api_v1_teams_path
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body).to be_an_instance_of(Hash)
      end
    end

    context 'when admin list teams' do
      let(:account) { create(:account) }

      let!(:team) do
        create_list(:team, 3, account_id: account.id)
      end

      before do
        sign_in admin
      end

      it 'should return 200 :ok' do
        get api_v1_teams_path
        expect(response).to have_http_status(:ok)
      end

      it 'should to be an instance of hash' do
        get api_v1_teams_path
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body).to be_an_instance_of(Hash)
      end
    end
  end

  describe 'GET /show' do
    let(:super_user) { create(:user, :super_user) }
    let(:admin) { create(:user, :admin) }
    let(:final_user) { create(:user, :user) }

    context 'when super_user try to retrieve a team does not exist' do
      before do
        sign_in super_user
      end

      it 'should return status 422 :unprocessable_entity' do
        get "#{api_v1_teams_path}/2"
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error' do
        get "#{api_v1_teams_path}/2"
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq("Couldn't find Team with 'id'=2")
      end
    end

    context 'when admin try to retrieve a team does not exist' do
      before do
        sign_in admin
      end

      it 'should return status 422 :unprocessable_entity' do
        get "#{api_v1_teams_path}/2"
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error' do
        get "#{api_v1_teams_path}/2"
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq("Couldn't find Team with 'id'=2")
      end
    end

    context 'when final_user try to retrieve a team does not exist' do
      before do
        sign_in final_user
      end

      it 'should return status 422 :unprocessable_entity' do
        get "#{api_v1_teams_path}/2"
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error' do
        get "#{api_v1_teams_path}/2"
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to show? this Symbol')
      end
    end

    context 'when super_user try to retrieve an account' do
      let(:account) { create(:account) }
      let(:team) { create(:team, account_id: account.id) }

      before do
        sign_in super_user
      end

      it 'should return status 200 :ok' do
        get "#{api_v1_teams_path}/#{team.id}"
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
      end

      it 'should return the queried account' do
        get "#{api_v1_teams_path}/#{team.id}"
        body = JSON.parse(response.body)
        expect(body['team']['id']).to eq(team.id)
      end
    end

    context 'when admin try to retrieve an account' do
      let(:account) { create(:account) }
      let(:team) { create(:team, account_id: account.id) }

      before do
        sign_in admin
      end

      it 'should return status 200 :ok' do
        get "#{api_v1_teams_path}/#{team.id}"
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
      end

      it 'should return the queried account' do
        get "#{api_v1_teams_path}/#{team.id}"
        body = JSON.parse(response.body)
        expect(body['team']['id']).to eq(team.id)
      end
    end

    context 'when final_user try to retrieve an account' do
      let(:account) { create(:account) }
      let(:team) { create(:team, account_id: account.id) }

      before do
        sign_in final_user
      end

      it 'should return 422 :unprocessable_entity' do
        get "#{api_v1_teams_path}/#{account.id}"
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return no content' do
        get "#{api_v1_teams_path}/#{account.id}"
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to show? this Symbol')
      end
    end
  end

  describe 'POST /create' do
    let(:super_user) { create(:user, :super_user) }
    let(:admin) { create(:user, :admin) }
    let(:final_user) { create(:user, :user) }
    let(:account) { create(:account) }

    context 'when super_user create an account' do
      before do
        sign_in super_user
      end

      it 'should return status 201 :created' do
        post api_v1_teams_path, params: {
          team: {
            name: 'Back',
            account_id: account.id
          }
        }
        expect(response).to have_http_status(:created)
      end

      it 'should return the account name' do
        post api_v1_teams_path, params: {
          team: {
            name: 'Back',
            account_id: account.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['team']['name']).to eq('Back')
      end

      it 'should return status 422 :unprocessable_entity' do
        post api_v1_teams_path, params: {
          team: {
            name: 'Back'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return error name' do
        post api_v1_teams_path, params: {
          team: {
            account_id: account.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('La validación falló: Name no puede estar en blanco')
      end
    end

    context 'when admin create an account' do
      before do
        sign_in admin
      end

      it 'should return status 201 :created' do
        post api_v1_teams_path, params: {
          team: {
            name: 'Back',
            account_id: account.id
          }
        }
        expect(response).to have_http_status(:created)
      end

      it 'should return the account name' do
        post api_v1_teams_path, params: {
          team: {
            name: 'Back',
            account_id: account.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['team']['name']).to eq('Back')
      end

      it 'should return status 422 :unprocessable_entity' do
        post api_v1_teams_path, params: {
          team: {
            name: 'Back'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return error name' do
        post api_v1_teams_path, params: {
          team: {
            account_id: account.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('La validación falló: Name no puede estar en blanco')
      end
    end

    context 'when final_user try to create an account' do
      before do
        sign_in final_user
      end

      it 'should return status 422 :unprocessable_entity' do
        post api_v1_teams_path, params: {
          team: {
            name: 'Back',
            account_id: account.id
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error' do
        post api_v1_teams_path, params: {
          team: {
            name: 'Back',
            account_id: account.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to create? this Symbol')
      end
    end
  end

  describe 'PUT /update' do
    let(:super_user) { create(:user, :super_user) }
    let(:admin) { create(:user, :admin) }
    let(:final_user) { create(:user, :user) }
    let(:account) { create(:account) }
    let(:team) { create(:team, account_id: account.id) }

    context 'when super_user update a team' do
      before do
        sign_in super_user
      end

      it 'should return 200 :ok' do
        put "#{api_v1_teams_path}/#{team.id}", params: {
          team: {
            name: 'Backend',
            account_id: account.id
          }
        }

        expect(response).to have_http_status(:ok)
      end

      it 'should show attributes updated' do
        put "#{api_v1_teams_path}/#{team.id}", params: {
          team: {
            name: 'Backend',
            account_id: account.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['team']['name']).to eq('Backend')
      end
    end

    context 'when admin update a team' do
      before do
        sign_in admin
      end

      it 'should return 200 :ok' do
        put "#{api_v1_teams_path}/#{team.id}", params: {
          team: {
            name: 'Backend',
            account_id: account.id
          }
        }

        expect(response).to have_http_status(:ok)
      end

      it 'should show attributes updated' do
        put "#{api_v1_teams_path}/#{team.id}", params: {
          team: {
            name: 'Backend',
            account_id: account.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['team']['name']).to eq('Backend')
      end
    end

    context 'when final_user update a team' do
      before do
        sign_in final_user
      end

      it 'should return 422 :unprocessable_entity' do
        put "#{api_v1_teams_path}/#{team.id}", params: {
          team: {
            name: 'Backend',
            account_id: account.id
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should show attributes updated' do
        put "#{api_v1_teams_path}/#{team.id}", params: {
          team: {
            name: 'Backend',
            account_id: account.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to update? this Symbol')
      end
    end
  end

  describe 'DELETE /delete' do
    let(:super_user) { create(:user, :super_user) }
    let(:admin) { create(:user, :admin) }
    let(:final_user) { create(:user, :user) }
    let(:account) { create(:account) }
    let(:team) { create(:team, account_id: account.id) }

    context 'when super_user delete a team' do
      before do
        sign_in super_user
      end

      it 'should return 204 :no_content' do
        delete "#{api_v1_teams_path}/#{team.id}"
        expect(response).to have_http_status(:no_content)
      end

      it 'should return 422 :unprocessable_entity' do
        delete "#{api_v1_teams_path}/2"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when admin delete a team' do
      before do
        sign_in admin
      end

      it 'should return 204 :no_content' do
        delete "#{api_v1_teams_path}/#{team.id}"
        expect(response).to have_http_status(:no_content)
      end

      it 'should return 422 :unprocessable_entity' do
        delete "#{api_v1_teams_path}/2"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when final_user delete a team' do
      before do
        sign_in final_user
      end

      it 'should return 422 :unprocessable_entity' do
        delete "#{api_v1_teams_path}/#{team.id}"
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return 422 :unprocessable_entity' do
        delete "#{api_v1_teams_path}/#{team.id}"
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to destroy? this Symbol')
      end
    end
  end

  describe 'POST /assign_user' do
    let(:super_user) { create(:user, :super_user) }
    let(:admin) { create(:user, :admin) }
    let(:final_user) { create(:user, :user) }
    let(:account) { create(:account) }
    let(:team) { create(:team, account_id: account.id) }

    context 'when super_user assign user to teams' do
      before do
        sign_in super_user
      end

      it 'should return status 201 :created' do
        post "#{api_v1_teams_path}/#{team.id}/assign", params: {
          team: {
            user_id: final_user.id
          }
        }
        expect(response).to have_http_status(:created)
      end

      it 'should return the team name' do
        post "#{api_v1_teams_path}/#{team.id}/assign", params: {
          team: {
            user_id: final_user.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['team']['users'][0]['id']).to eq(final_user.id)
      end

      it 'should return status 422 :unprocessable_entity' do
        post "#{api_v1_teams_path}/2/assign", params: {
          team: {
            user_id: final_user.id
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error' do
        post "#{api_v1_teams_path}/2/assign", params: {
          team: {
            user_id: final_user.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq("Couldn't find Team with 'id'=2")
      end
    end

    context 'when admin assign user to teams' do
      before do
        sign_in admin
      end

      it 'should return status 201 :created' do
        post "#{api_v1_teams_path}/#{team.id}/assign", params: {
          team: {
            user_id: final_user.id
          }
        }
        expect(response).to have_http_status(:created)
      end

      it 'should return the account name' do
        post "#{api_v1_teams_path}/#{team.id}/assign", params: {
          team: {
            user_id: final_user.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['team']['users'][0]['id']).to eq(final_user.id)
      end

      it 'should return status 422 :unprocessable_entity' do
        post "#{api_v1_teams_path}/2/assign", params: {
          team: {
            user_id: final_user.id
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error' do
        post "#{api_v1_teams_path}/2/assign", params: {
          team: {
            user_id: final_user.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq("Couldn't find Team with 'id'=2")
      end
    end

    context 'when final_user assign user to teams' do
      before do
        sign_in final_user
      end

      it 'should return status 422 :unprocessable_entity' do
        post "#{api_v1_teams_path}/#{team.id}/assign", params: {
          team: {
            user_id: final_user.id
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error' do
        post "#{api_v1_teams_path}/#{team.id}/assign", params: {
          team: {
            user_id: final_user.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to assign_user? this Symbol')
      end
    end
  end

  describe 'POST /remove_user' do
    let(:super_user) { create(:user, :super_user) }
    let(:admin) { create(:user, :admin) }
    let(:final_user) { create(:user, :user) }
    let(:account) { create(:account) }
    let(:team) { create(:team, account_id: account.id) }

    context 'when super_user remove user to teams' do
      before do
        sign_in super_user
      end

      it 'should return status 201 :created' do
        post "#{api_v1_teams_path}/#{team.id}/remove", params: {
          team: {
            user_id: final_user.id
          }
        }
        expect(response).to have_http_status(:created)
      end

      it 'should return status 422 :unprocessable_entity' do
        post "#{api_v1_teams_path}/2/remove", params: {
          team: {
            user_id: final_user.id
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error' do
        post "#{api_v1_teams_path}/2/remove", params: {
          team: {
            user_id: final_user.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq("Couldn't find Team with 'id'=2")
      end
    end

    context 'when admin remove user to teams' do
      before do
        sign_in admin
      end

      it 'should return status 201 :created' do
        post "#{api_v1_teams_path}/#{team.id}/remove", params: {
          team: {
            user_id: final_user.id
          }
        }
        expect(response).to have_http_status(:created)
      end

      it 'should return status 422 :unprocessable_entity' do
        post "#{api_v1_teams_path}/2/remove", params: {
          team: {
            user_id: final_user.id
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error' do
        post "#{api_v1_teams_path}/2/remove", params: {
          team: {
            user_id: final_user.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq("Couldn't find Team with 'id'=2")
      end
    end

    context 'when final_user remove user to teams' do
      before do
        sign_in final_user
      end

      it 'should return status 422 :unprocessable_entity' do
        post "#{api_v1_teams_path}/#{team.id}/remove", params: {
          team: {
            user_id: final_user.id
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should return message error' do
        post "#{api_v1_teams_path}/#{team.id}/remove", params: {
          team: {
            user_id: final_user.id
          }
        }
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to remove_user? this Symbol')
      end
    end
  end
end
