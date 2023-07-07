Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    registrations: 'user/registrations'
  }
  root to: 'pages#home'
  resources :groups, only: %i[index new create show edit update] do
    resources :expenses, only: %i[show edit update]
  end

  get '/up/', to: 'up#index', as: :up
  get '/up/databases', to: 'up#databases', as: :up_databases
end
