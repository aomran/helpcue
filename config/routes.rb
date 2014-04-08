Helpcue::Application.routes.draw do
  resources :requests

  root 'classrooms#index'
  devise_for :users

  # Resources
  resources :classrooms, except: [:show, :new] do
    post 'join', on: :collection
    resources :requests, only: [:index, :create] do
      patch 'remove', on: :member
    end
  end

  # Development Environment
  if Rails.env.development?
    mount StyleGuide::Engine => "/style-guide"
  end
end
