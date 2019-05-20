Rails.application.routes.draw do
  resources :exchanges, only: [:index]
  get 'exchanges/convert'
  get '/', to: 'exchanges#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
