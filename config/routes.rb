Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :companies, only: [ :index, :new, :create, :delete, :show, :update] do
    resources :invoices, only: [ :index, :new, :show, :update, :create, :destroy ]
    resources :operations, only: [ :index, :new, :show, :update, :create ]

    get '/fetch_operations', to: 'operations#fetch'
  end

  get :components, to: 'pages#components'
  get 'companies/:id/dashboard', to: 'companies#dashboard', as: :company_dashboard

  resources :chats, only: :show do
    resources :messages, only: :create
  end

  get 'pages/download', to: 'pages#download'

  get '/new_user', to: 'bankin#new_user'

  get 'list_transactions', to: 'bankin#list_transactions'
end
