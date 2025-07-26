Rails.application.routes.draw do
  get 'profiles/show'
  get 'profiles/edit'
  get 'accounts/show'
  get 'reservations/index'
  get 'rooms/index'
  devise_for :users
  root 'users#index'
  get 'users/index'
  resource :account, only: [:show]
  resource :profiles, only: [:show ,:edit, :update]
  resources :users
  resources :rooms do
    collection do
      get :search
    end
  end
  resources :reservations do
    post 'confirm', on: :collection
    post 'confirm_update', on: :member
  end
end
