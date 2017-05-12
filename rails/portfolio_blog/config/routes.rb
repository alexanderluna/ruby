Rails.application.routes.draw do
  root                          'posts#index'
  get 'admin_einloggen'     =>  'sessions#new'
  post 'admin_einloggen'    =>  'sessions#create'
  delete 'admin_abmelden'   =>  'sessions#destroy'

  resources :posts
  resources :sections
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
