Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  post 'issue/delAtt'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]
  resources :issues do
  resources :comments
  resources :votes
       resources :watches
  end
  resources :users
  root to: "issues#index"
end
