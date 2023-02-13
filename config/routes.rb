# frozen_string_literal: true

Rails.application.routes.draw do
  # Sessions
  devise_for :users, skip: %i[sessions passwords]

  devise_scope :user do
    post '/api/v1/login', to: 'api/v1/sessions/authentication#create'
    delete '/api/v1/logout', to: 'api/v1/sessions/authentication#destroy'
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index create show update destroy]
    end
  end
end
