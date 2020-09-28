# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

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

  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
