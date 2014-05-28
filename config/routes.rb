Helpcue::Application.routes.draw do
  resources :requests

  root 'classrooms#index'
  devise_for :users, :controllers => { :registrations => "registrations", :omniauth_callbacks => "users/omniauth_callbacks" }

  # Resources
  resources :classrooms, except: [:show, :new, :edit] do
    post 'join', on: :collection
    get 'people', on: :member
    patch 'set_sort', on: :member
    resources :requests, only: [:index, :create, :update, :destroy, :show] do
      patch 'remove', on: :member
      patch 'toggle_help', on: :member
      patch 'me_too', on: :member
      get 'completed', on: :collection
      get 'search', on: :collection
    end

    resources :users, only: [:destroy, :update]
    get "hashtags/:hashtag",   to: "hashtags#show",      as: :hashtag
    get "hashtags",   to: "hashtags#show",      as: :hashtag_search
    resources :invitations, only: [:create]
  end

  # Development Environment
  if Rails.env.development?
    mount StyleGuide::Engine => "/style-guide"
  end
end
