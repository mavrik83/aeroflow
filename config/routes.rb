# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '/auth/:provider/callback' => 'sessions#oauth'

  resources :categories
  resources :questions do
    resources :answers, only: %i[new create index]
    # resources :questions do
    #   resources :answers, only: [:index, :new, :create]
    # end
    # resources :answers, only: [:show, :edit, :update, :destroy]
  end
  resources :answers, only: [:index, :destroy, :edit, :update]
  resources :users, except: [:new]
end
