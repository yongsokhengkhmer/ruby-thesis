Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  resources :users, only: :show do
    get "followings" => "follow_infos#followings"
    get "followers" => "follow_infos#followers"
    resources :activities, only: :index
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
  resources :feedbacks, only: [:new, :create]
  resources :conversations, only: [:index, :show, :create]
  resources :messages, only: [:create]
  get "searches/users"
  get "searches/jobs"
  get "recommendations/recruiters" => "recommendations#recruiters"
  get "recommendations/applicants" => "recommendations#applicants"

  namespace :admin do
    root to: "applicants#index"
    resources :applicants, only: [:index, :destroy]
    resources :recruiters, only: [:index, :destroy]
    resources :posts, only: [:index, :destroy]
    resources :job_posts, only: :index
    resources :feedbacks, only: [:index, :show, :destroy]
    resources :job_types, except: :show
    resources :salary_types, except: :show
    resources :countries, except: :show
  end
  root "static_pages#home"
end
