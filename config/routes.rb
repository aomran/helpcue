Helpcue::Application.routes.draw do
  resources :requests

  root 'classrooms#index'
  devise_for :users

  # Resources
  resources :classrooms, except: [:show, :new] do
    post 'join', on: :collection
    resources :requests, only: [:index, :create, :update, :destroy, :show] do
      patch 'remove', on: :member
      patch 'toggle_help', on: :member
      patch 'me_too', on: :member
      get 'completed', on: :collection
    end

    resources :users, only: [:destroy]
  end

  # Development Environment
  if Rails.env.development?
    mount StyleGuide::Engine => "/style-guide"
  end
end
