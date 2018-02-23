Rails.application.routes.draw do
  get 'users/show'

  devise_for :users

  resources :users, only: [:show]

  resources :topics do
    resources :bookmarks, except: [:index] do
      resources :likes, only: [:index, :create, :destroy]
    end
  end

  post :incoming, to: 'incoming#create'

  root 'topics#index'
end
