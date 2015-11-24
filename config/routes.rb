require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  authenticate :admin_user do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: "home#index"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  resources :territories, only: [:index, :show]
  resources :bookings, only: [] do
    resources :credit_cards, only: [:index, :new, :create], controller: 'bookings/credit_cards'
    resource :payment, only: [:show, :new, :create], controller: 'bookings/payment'
  end

  resources :profiles, only: [:show]

  namespace :account do
    resources :bookings, only: [] do
      resource :accept, only: [:create, :new], controller: "bookings/accept"
      resource :reject, only: :create, controller: "bookings/reject"
      resource :reviews, only: [:new, :create], controller: "bookings/reviews"
      resource :client_archive, only: :create, controller: "bookings/client_archive"
      resource :owner_archive, only: :create, controller: "bookings/owner_archive"
      resources :address, only: [:new, :create, :edit, :update], controller: "bookings/address"
    end

    resource :dashboard, only: :show, controller: "dashboard"

    resources :territories, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :bookings, only: [:index, :new, :create]
      resources :photos, only: [:new, :create, :destroy]
    end

    resource :profile, only: [:edit, :update], controller: "profile"
  end
end
