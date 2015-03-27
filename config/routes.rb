Rails.application.routes.draw do
  root 'classrooms#index'

  # Devise User
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'register',
      edit: 'profile/edit'
    },
    controllers: {
      registrations:      "registrations",
      omniauth_callbacks: "users/omniauth_callbacks"
    }

  # Resources
  resources :classrooms, except: [:show, :new, :edit] do
    post  'join',     on: :collection
    patch 'set_sort', on: :member

    resources :requests, except: [:new, :edit] do
      patch 'me_too',      on: :member
      get   'completed',   on: :collection
      get   'search',      on: :collection
    end

    resources :users, only: [:destroy, :update, :index]
    resources :invitations, only: [:create]
    get "hashtags/:hashtag",   to: "hashtags#show", as: :hashtag
    get "hashtags",            to: "hashtags#show", as: :hashtag_search
  end

  # Development Environment
  if Rails.env.development?
    mount StyleGuide::Engine => "/style-guide"
  end
end
