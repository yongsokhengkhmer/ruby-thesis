Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  root "static_pages#home"
  resources :users, only: :show
  resources :job_posts, only: [:index, :show] do
    resources :apply_jobs, only: [:new, :create]
  end
  resources :save_posts, only: [:index, :create, :destroy]
  resources :activities, only: [:show, :edit, :destroy]
  resources :share_posts, only: [:new, :create, :update]

  get "profiles" => "profiles#index"
  get "profiles/edit" => "profiles#edit", as: :edit_profile
  patch "profiles/edit" => "profiles#update"
  get "passwords" => "passwords#edit"
  patch "passwords" => "passwords#update"
  put "update_seen_notifications" => "notification_seen_updates#update"

  resources :posts, only: [:create, :update]
  resources :like_posts, only: [:create, :destroy]
end
