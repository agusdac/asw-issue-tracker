Rails.application.routes.draw do
  resources :issues
  resources :users
  root 'issues#index'
end
