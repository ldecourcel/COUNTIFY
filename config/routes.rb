Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :companies, only: [ :index, :new, :create, :delete, :show] do
    resources :invoices, only: [ :index, :new,  :create ]
    resources :operations, only: [ :index, :new,  :create ]
  end

  resources :operations, only: [ :update, :show ]
  resources :invoices, only: [ :update, :show, :destroy ]

  get :components, to: 'pages#components'
end
