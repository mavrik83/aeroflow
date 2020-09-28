# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  resources :answers
  resources :tags
  resources :categories
  resources :questions
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
