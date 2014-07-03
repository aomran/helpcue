Helpcue::Application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      # Devise User
      devise_for :users,
        controllers: {
          sessions: 'api/v1/devise/sessions',
          registrations: 'api/v1/devise/registrations',
          omniauth_callbacks: 'api/v1/devise/omniauth_callbacks'
        }

      # Resources
      resources :classrooms, except: [:show, :new, :edit] do
        post  'join',     on: :collection
        patch 'set_sort', on: :member

        resources :requests, except: [:new, :edit] do
          patch 'remove',      on: :member
          patch 'toggle_help', on: :member
          patch 'me_too',      on: :member
          get   'completed',   on: :collection
          get   'search',      on: :collection
        end

        resources :users, only: [:destroy, :update, :index]
        resources :invitations, only: [:create]
        get "hashtags/:hashtag",   to: "hashtags#show", as: :hashtag
        get "hashtags",            to: "hashtags#show", as: :hashtag_search
      end
    end
  end

end
