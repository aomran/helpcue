Helpcue::Application.routes.draw do
  root 'users#index'
  devise_for :users

  if Rails.env.development?
    mount StyleGuide::Engine => "/style-guide"
  end
end
