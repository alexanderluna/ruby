Rails.application.routes.draw do
  resources :users
  root 'welcome#index'
  get 'welcome/index'
  post '/send_email', to: 'welcome#send_email', as: 'send_email'
  get '/unsubscribe' => 'welcome#unsubscribe'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
