Rails.application.routes.draw do

  devise_for :users, path: 'user',
             controllers: {
               sessions: 'users/sessions',
               passwords: 'users/passwords',
               omniauth_callbacks: "users/omniauth_callbacks"
             }
  devise_scope :user do
    #get  'user/profile', to: 'users/registrations#profile', as: :user_profile
    #patch 'user/profile', to: 'users/registrations#update_profile'
    #post 'user/destroy_attachment', to: 'users/registrations#destroy_attachment', as: :user_destroy_attachment
    #post "/subscribe" => "users/registrations#subscribe", :as => :getKey
    get '/user/sign_out' => 'devise/sessions#destroy'
  end

  authenticated :user do
    root to: 'graduate_project#index'
  end
  unauthenticated :user do
    devise_scope :user do
      get '/', to: 'users/sessions#new'
    end
  end

  namespace :admin do
    resources :projects
    resources :customers
    resources :users
  end
end
