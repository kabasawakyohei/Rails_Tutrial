Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'

  # get 'static_pages/help'
  get '/help', to: 'static_pages#help', as: 'helf'

  # get 'static_pages/about'
  get '/about', to: 'static_pages#about'

  # get 'static_pages/contact'
  get '/contact', to: 'static_pages#contact'

  # get 'users/new'
  get '/signup' , to: 'users#new'
  
  # ログインリソース  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # ユーザーリソース
  resources :users
  # メールの有効化リソース
  resources :account_activations, only: [:edit]

  # ツイートリソース
  resources :tweets, only: [:create, :destroy]
end
