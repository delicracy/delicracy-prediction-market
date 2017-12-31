Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :transactions
  get 'static_pages/home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  resources :users do
    get 'account', to: 'users#account'
    get 'histories(/:type)', to: 'histories#index', as: 'histories', defaults: { type: :all }
  end

  get 'races(/category/:category)', to: 'races#index', as: 'races', defaults: { category: :all }
  resources :races, except: :index do
    put 'start', to: 'races#start'
    member do
      get :data_series
    end
    resources :lanes, param: :lane_id do
      post 'offers', to: 'offers#create', as: 'offers'
    end
    put 'oracle/:user_id', to: 'races#assign_to_oracle', as: 'assign_to_oracle'
  end

  scope :chat_rooms, defaults: { format: :json } do
    get ':race_id/join/:user_id', to: 'chat_rooms#join'
    get ':race_id/user_info/:user_id', to: 'chat_rooms#user_info'
    get ':race_id/update', to: 'chat_rooms#update'
  end

  get     '/signup',  to: 'users#new'
  post    '/signup',  to: 'users#create'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'
end
