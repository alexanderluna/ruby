Rails.application.routes.draw do
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
  resources :products
  get 'up' => 'rails/health#show', as: :rails_health_check
end
