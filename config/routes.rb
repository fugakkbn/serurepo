# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get 'tos', to: 'welcome#tos', as: 'tos'
  get 'privacy_policy', to: 'welcome#privacy_policy', as: 'privacy_policy'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :users do
      resources :lists, only: %i[show]
    end
  end

  namespace :users do
    resources :lists, only: %i[create show]
  end

  resources :books, only: %i[index]
  resources :list_details, only: %i[destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
