Rails.application.routes.draw do

  devise_for :users, path: 'user',
             controllers: {
               sessions: 'users/sessions',
               passwords: 'users/passwords',
               omniauth_callbacks: "users/omniauth_callbacks"
             }
  devise_scope :user do
    get  'user/profile', to: 'users/registrations#profile', as: :user_profile
    patch 'user/profile', to: 'users/registrations#update_profile'
    post 'user/destroy_attachment', to: 'users/registrations#destroy_attachment', as: :user_destroy_attachment
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
    resources :projects do
      resources :products do
        collection do
          get :autocomplete
          get :export_template
          post :import
          get :search
        end
        member do
          post :destroy_attachment
        end
      end
      member do
        post :destroy_attachment
      end
      collection do
        get :autocomplete
        get :search
        post :import
      end
      #resources :layouts do
      #  collection do
      #    post :get_divisions
      #  end
      #end
      #resources :custom_details, only: [:index, :create]
      #resources :interactive_layouts do
      #  collection do
      #    post :get_divisions
      #    post :find_divisions
      #  end
      #end
    end
    resources :roles
    resources :customers do
      collection do
        get :autocomplete
      end
    end
    resources :investors do
      member do
        post :destroy_attachment
      end
      collection do
        get :autocomplete
        get :search
      end
    end
    resources :constructors do
      member do
        post :destroy_attachment
      end
      collection do
        get :autocomplete
        get :search
      end
    end
    resources :developments do
      member do
        post :destroy_attachment
      end
      collection do
        get :autocomplete
        get :search
      end
    end
    resources :operators do
      member do
        post :destroy_attachment
      end
      collection do
        get :autocomplete
        get :search
      end
    end
    resources :users do
      collection do
        get :autocomplete
        get :account_autocomplete
        get :search
        end
    end
    resources :regions do
      collection do
        post :get_regions, to: 'regions#get_regions'
      end
    end
  end
end
