Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  resources :users, only: :show
  get "profiles" => "profiles#index"
  get "profiles/edit" => "profiles#edit", as: :edit_profile
  patch "profiles/edit" => "profiles#update"
  get "passwords" => "passwords#edit"
  patch "passwords" => "passwords#update"
end
