Rails.application.routes.draw do
  # resources :exchanges, only: [:index]
  root 'exchanges#index'
  get 'convert', to: 'exchanges#convert'
end
