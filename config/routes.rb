Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'

  # getルールを使って変更すると、GETリクエストが /help に送信されたときにStaticPagesコントローラーのhelpアクションを呼び出すようになる(また、help_pathやhelp_urlといった名前付きルートも使えるようになる)

  #static_controller
  get '/help', to:'static_pages#help'
  get '/about', to:'static_pages#about'
  get '/contact', to:'static_pages#contact'

  #users_controller
  get  '/signup', to:'users#new'

  resources :users do
    member do
      get :following, :followers
    end
  end

  #sessions_controller
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'

  #account_activations_controller
  resources :account_activations, only: [:edit]
  
  #password_resets_controller
  resources :password_resets, only: [:new, :create, :edit, :update]

  # microposts_controller
  resources :microposts, only: [:create, :destroy]

  #relationships_controller
  resources :relationships, only: [:create, :destroy]

  # to: '~'の後に ,as: "別名"とすると名前付きルートを変更できる

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
