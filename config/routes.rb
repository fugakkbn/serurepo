# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :users do
    get 'list/create'
    get 'list/show'
    get 'list/update'
  end
  root 'home#index'
  devise_for :users
  resources :books, only: %i[index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
