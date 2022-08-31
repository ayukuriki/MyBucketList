Rails.application.routes.draw do
  root 'top#index'
  get "mypage" => "lists#index"
  get "sharepage" => "lists#all_index" 
  resources :lists, only: [:new, :create, :edit, :update, :destroy]
end
