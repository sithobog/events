Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', skip: [:registrations], at: 'auth'
  #devise_for :users,skip: [:confirmations, :passwords, :sessions, :registrations], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    #get 'sign_in',     to: 'devise/sessions#new', as: :new_user_session
    delete 'auth/sign_out', to: 'devise_token_auth/sessions#destroy', as: :destroy_user_session
  end

  namespace :api do
    namespace :v1 do
      resources :events do
        resources :comments
      end
    end
  end

  root to: "home#index"
end
