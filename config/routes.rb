Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  root "static_pages#home"
  resources :users, only: :show
  resources :job_posts, only: :show do
    resources :apply_jobs, only: [:new, :create]
  end
  resources :job_posts, only: [:index, :show]

  get "profiles" => "profiles#index"
  get "profiles/edit" => "profiles#edit", as: :edit_profile
  patch "profiles/edit" => "profiles#update"
  get "passwords" => "passwords#edit"
  patch "passwords" => "passwords#update"
  put "update_seen_notifications" => "notification_seen_updates#update"
end
