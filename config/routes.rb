Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  root "static_pages#home"
  resources :users, only: :show do
    get "followings" => "follow_infos#followings"
    get "followers" => "follow_infos#followers"
  end
  resources :job_posts, only: [:index, :show] do
    resources :apply_jobs, only: [:new, :create]
  end
  resources :save_posts, only: [:index, :create, :destroy]
  resources :activities, only: [:show, :edit, :destroy]
  resources :share_posts, only: [:new, :create, :update]
  resources :apply_jobs, only: [:index]

  get "profiles" => "profiles#index"
  get "profiles/edit" => "profiles#edit", as: :edit_profile
  patch "profiles/edit" => "profiles#update"
  get "passwords" => "passwords#edit"
  patch "passwords" => "passwords#update"
  put "update_seen_notifications" => "notification_seen_updates#update"
  put "update_read_messages/:conversation_id" => "notification_seen_updates#update_messages"

  resources :posts, only: [:index, :create, :update]
  resources :like_posts, only: [:create, :destroy]
  resources :mark_interests, only: [:create, :destroy]
  resources :comments, only: [:index, :create]
  resources :relationships, only: [:create, :destroy]
  resources :feedbacks, except: [:edit, :update, :destroy]
  resources :conversations, only: [:index, :show, :create]
  resources :messages, only: [:create]
  get "searches/users"
  get "searches/jobs"

  namespace :admin do
    resources :applicants, only: [:index, :destroy]
  end
end
