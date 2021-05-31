Rails.application.routes.draw do
  devise_for :users
  root to: 'health#index'
end
