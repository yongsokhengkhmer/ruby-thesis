Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  root "static_pages#home"
  resources :users, only: :show
  resources :job_posts, only: :show do
    resources :apply_jobs, only: [:new, :create]
  end

  get "profiles" => "profiles#index"
  get "profiles/edit" => "profiles#edit", as: :edit_profile
  patch "profiles/edit" => "profiles#update"
  get "passwords" => "passwords#edit"
  patch "passwords" => "passwords#update"
end
