Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :companies, only: [ :index, :new, :create, :delete, :show] do
    resources :invoices, only: [ :index, :new, :show, :update, :create, :destroy ]
    resources :operations, only: [ :index, :new, :show, :update, :create ]
  end

  get :components, to: 'pages#components'
  get 'companies/:id/dashboard', to: 'companies#dashboard', as: :company_dashboard
end
