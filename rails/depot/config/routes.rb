Rails.application.routes.draw do
  root 'store#index', as: 'store_index'
  resources :products
  get 'up' => 'rails/health#show', as: :rails_health_check
end
