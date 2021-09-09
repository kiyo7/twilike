Rails.application.routes.draw do

  root 'static_pages#home'

  # getルールを使って変更すると、GETリクエストが /help に送信されたときにStaticPagesコントローラーのhelpアクションを呼び出すようになる(また、help_pathやhelp_urlといった名前付きルートも使えるようになる)

  #static_controller
  get '/help', to:'static_pages#help'
  get '/about', to:'static_pages#about'
  get '/contact', to:'static_pages#contact'

  #users_controller
  get  '/signup', to:'users#new'

  resources :users

  #sessions_controller
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'

  #account_activations_controller
  resources :account_activations, only: [:edit]

  # to: '~'の後に ,as: "別名"とすると名前付きルートを変更できる

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
