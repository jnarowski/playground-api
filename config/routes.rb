Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: 'users/registrations',
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  match 'ping' => 'application#ping', via: :all
  match 'auth_ping' => 'application#auth_ping', via: :all

  resources :airtable, only: [:index, :show]
end