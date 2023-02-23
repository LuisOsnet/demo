# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'User#index' do
    let(:super_user) { create(:user, :super_user) }

    context 'when are no registered users' do
      before do
        sign_in super_user
      end
      it 'should return no content' do
        get api_v1_users_path

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when super_user list users' do
      let!(:users) do
        create_list(:user, 3, :user)
      end

      before do
        sign_in super_user
      end
      it 'should return an array' do
        get api_v1_users_path

        body = JSON.parse(response.body)
        expect(body).to be_an_instance_of(Hash)
      end
    end

    context 'when final user try to list users' do
      let(:final_user) { create(:user, :user) }
      let!(:users) do
        create_list(:user, 3, :user)
      end

      before do
        sign_in final_user
      end
      it 'should return error 422 (:unprocessable_entity)' do
        get api_v1_users_path

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'User#show' do
    let(:super_user) { create(:user, :super_user) }
    let(:final_user) { create(:user, :user) }
    context 'when user does not exist' do
      before do
        sign_in super_user
      end
      it 'should return no content' do
        get "#{api_v1_users_path}/2"
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when user is present' do
      let(:final_user) { create(:user, :user) }

      before do
        sign_in super_user
      end
      it 'should return status 200' do
        get "#{api_v1_users_path}/#{final_user.id}"
        expect(response).to have_http_status(:ok)
      end

      it 'should return a hash' do
        get "#{api_v1_users_path}/#{final_user.id}"
        body = JSON.parse(response.body)
        expect(body).to be_an_instance_of(Hash)
      end

      it 'should return the queried user' do
        get "#{api_v1_users_path}/#{final_user.id}"
        body = JSON.parse(response.body)
        expect(body['user']['id']).to eq(final_user.id)
      end
    end

    context 'when final user try to retrive another user' do
      let(:user) { create(:user, :user) }
      before do
        sign_in final_user
      end
      it 'should return its own data' do
        get "#{api_v1_users_path}/#{user.id}"
        body = JSON.parse(response.body)
        expect(body['user']['id']).to eq(final_user.id)
      end
    end
  end

  describe 'user#create' do
    let(:super_user) { create(:user, :super_user) }
    let(:final_user) { create(:user, :user) }
    context 'when final user try to create another user' do
      let(:user) { create(:user, :user) }
      before do
        sign_in final_user
      end
      it 'should return 422 :unprocessable_entity' do
        post api_v1_users_path, params: create_params
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to create? this Symbol')
      end
    end

    context 'when super user try to create a new user' do
      let(:super_user) { create(:user, :super_user) }
      before do
        sign_in super_user
      end
      it 'should return 201 :created' do
        post api_v1_users_path, params: create_params
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
      end
    end

    context 'when super user try to create a new user without some attribute' do
      let(:super_user) { create(:user, :super_user) }
      before do
        sign_in super_user
      end
      it 'should return 422 :unprocessable_entity' do
        post api_v1_users_path, params: create_params_with_missign_attribute
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'User#update' do
    let(:super_user) { create(:user, :super_user) }
    let(:final_user) { create(:user, :user) }
    let(:user) { create(:user, :user) }
    context 'when final user try to update another user' do
      before do
        sign_in final_user
      end
      it 'should return 422 :unprocessable_entity' do
        put "#{api_v1_users_path}/#{user.id}", params: update_params
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to update? this Symbol')
      end
    end

    context 'when super user try to update an user' do
      before do
        sign_in super_user
      end
      it 'should return 200 :ok' do
        put "#{api_v1_users_path}/#{user.id}", params: update_params
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
      end

      it 'should return updated data' do
        put "#{api_v1_users_path}/#{user.id}", params: update_params
        body = JSON.parse(response.body)
        expect(body['user']['name']).to eq(update_params[:user][:name])
      end
    end
  end

  describe 'User#delete' do
    let(:super_user) { create(:user, :super_user) }
    let(:final_user) { create(:user, :user) }
    let(:user) { create(:user, :user) }
    context 'when final user try to delete another user' do
      before do
        sign_in final_user
      end
      it 'should return 422 :unprocessable_entity' do
        delete "#{api_v1_users_path}/#{user.id}"
        body = JSON.parse(response.body)
        expect(body['error']['details']).to eq('not allowed to destroy? this Symbol')
      end
    end

    context 'when super user try to delete an user' do
      before do
        sign_in super_user
      end
      it 'should return 204 :no_content' do
        delete "#{api_v1_users_path}/#{user.id}"
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'wwhen the superuser tries to delete a non-existent user' do
      before do
        sign_in super_user
      end
      it 'should return 422 :unprocessable_entity' do
        delete "#{api_v1_users_path}/2"
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  def create_params
    {
      user: {
        name: 'Jon Doe',
        level_english: 'A1',
        technical_knowledge: 'Javascript',
        resume_url: 'https://docs.google.com/document/d/1Y4ZCwrgKJ4WV5W109cF4XN20d3Klt7SNCrjQagOhh8E',
        email: 'jondue@gmail.com',
        password: 'password',
        role: 'admin'
      }
    }
  end

  def create_params_with_missign_attribute
    {
      user: {
        name: 'Jon Doe',
        technical_knowledge: 'Javascript',
        resume_url: 'https://docs.google.com/document/d/1Y4ZCwrgKJ4WV5W109cF4XN20d3Klt7SNCrjQagOhh8E',
        email: 'jondue@gmail.com',
        password: 'password',
        role: 'admin'
      }
    }
  end

  def update_params
    {
      user: {
        name: 'Jon Something',
        level_english: 'C1',
        technical_knowledge: 'React',
        resume_url: 'https://docs.google.com/document/d/1Y4ZCwrgKJ4WV5W109cF4XN20d3Klt7SNCrjQagOhh8E',
        email: 'jonshomething@gmail.com',
        password: 'password',
        role: 'user'
      }
    }
  end
end
