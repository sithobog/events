Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', skip: [:registrations], at: 'auth',
                                      controllers: { omniauth_callbacks: 'api/v1/omniauth_callbacks'}
  devise_scope :user do
    delete 'auth/sign_out', to: 'devise_token_auth/sessions#destroy', as: :destroy_user_session
  end

  namespace :api do
    namespace :v1 do
      resources :events do
        resources :comments
        resources :event_invites, only: :create
      end
    end
  end

  root to: "home#index"
end
