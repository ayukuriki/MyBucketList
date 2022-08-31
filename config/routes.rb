Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'top#index'
  get "mypage" => "lists#index"
  get "sharepage" => "lists#all_index" 
  get "my_achieved_lists" => "achieved_lists#my_index"
  get "users/show" => "users#show"
  resources :lists, only: [:new, :create, :edit, :update, :destroy]
  resources :achieved_lists, only: [:index, :new, :create, :destroy]
  resources :questions, only: [:index, :show, :new, :create]
  resources :advices, only: [:create, :destroy]
  resources :achieved_lists do
    resource :congrats, only: [:create, :destroy]
 end
end
