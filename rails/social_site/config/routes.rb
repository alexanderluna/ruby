Rails.application.routes.draw do

  root                'static_pages#home'
  get 'show_admin'=>  'users#show_admin'
  get 'privacy'   =>  'static_pages#privacy'
  get 'feed'      =>  'static_pages#feed'
  get 'featured'  =>  'static_pages#feature'
  get 'resource'  =>  'static_pages#resource_material'
  get 'signup'    =>  'users#new'
  get 'login'     =>  'sessions#new'
  post 'login'    =>  'sessions#create'
  delete 'logout' =>  'sessions#destroy'
  get '/subscribe'              => 'static_pages#subscribe'
  get '/unsubscribe'            => 'static_pages#unsubscribe'
  get '/unsubscribe_notify'     => 'static_pages#unsubscribe_notify'
  post '/send_email',           to: 'static_pages#send_email', as: 'send_email'
  get 'auth/facebook/callback'  => 'sessions#create_facebook'
  get 'auth/instagram/callback' => 'sessions#create_instagram'
  get 'auth/twitter/callback'   => 'sessions#create_facebook'
  get 'auth/failure'            => 'users#new'
  post 'notification'           => 'simple_mail#notification'
  post 'complaint'              => 'simple_mail#complaint'
  get '/sitemap.xml.gz', to: redirect("https://s3-us-west-2.amazonaws.com/hyouka/sitemaps/sitemap.xml.gz"), as: :sitemap
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :password_reset, only: [:new, :create, :edit, :update]
  resources :microposts do
    resources :comments,     only: [:create, :destroy]
    get 'toggle_approve',    :on => :member
    member do
      get 'like'
      get 'unlike'
    end
  end
  get 'microposts/:id/*slug'    => 'microposts#show'
  resources :ads,            only: [:show, :create, :edit, :update]
  resources :relationships,  only: [:create, :destroy]
  resources :notifications,  only: [:index, :destroy]
  
end
