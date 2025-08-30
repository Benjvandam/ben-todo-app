Rails.application.routes.draw do
  devise_for :users
  root "lists#index"

  resources :lists, only: [:create, :update, :destroy] do  
    resources :tasks, only: [:create, :destroy]
  end

  resources :tasks, only: [:show, :update] do 
    resources :comments, only: [:create, :update, :destroy]
  end
end
