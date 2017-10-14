Rails.application.routes.draw do
  resources :tacos
  root to: 'tacos#index'
end
