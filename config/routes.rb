# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # resources :answers
  resources :tags
  resources :categories
  resources :questions do
    resources :answers, shallow: true
    # resources :articles do
    #   resources :comments, only: [:index, :new, :create]
    # end
    # resources :comments, only: [:show, :edit, :update, :destroy]
  end

  resources :users, except: [:new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
