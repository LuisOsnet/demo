# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Sessions
  devise_for :users, skip: %i[sessions passwords]

  devise_scope :user do
    post '/api/v1/login', to: 'api/v1/sessions/authentication#create'
    delete '/api/v1/logout', to: 'api/v1/sessions/authentication#destroy'
  end

  namespace :api do
    namespace :v1 do
      resources :users, defaults: { format: :json }, only: %i[index create show update destroy]
      resources :accounts, defaults: { format: :json }, only: %i[index create show update destroy]
      resources :teams, defaults: { format: :json }, only: %i[index create show update destroy] do
        member do
          post :assign, to: 'teams#assign_user', as: :assign_user
          post :remove, to: 'teams#remove_user', as: :remove_user
        end
      end

      resources :tracks, defaults: { format: :json }, only: %i[index]
    end
  end
end
