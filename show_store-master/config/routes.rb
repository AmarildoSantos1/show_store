Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'authenticate', to: 'authentication#authenticate'
  post 'register', to: 'authentication#register'

  get 'items', to: 'item#index'

  get 'user_items', to: 'user_item#index'
  post 'user_items/:item_id', to: 'user_item#create'

  get 'orders', to: 'order#index'
  post 'orders', to: 'order#create'
end
