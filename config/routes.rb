Rails.application.routes.draw do

  scope module: :user do
    devise_for :users, skip: :all
    devise_scope :user do
      get    'users/login'         => 'devise/sessions#new',         as: :new_user_session
      post   'users/login'         => 'devise/sessions#create',      as: :user_session
      delete 'users/logout'        => 'devise/sessions#destroy',     as: :destory_user_session
      get    'users/signup'        => 'devise/registrations#new',    as: :new_user_registration
      post   'users/signup'        => 'devise/registrations#create', as: :user_registration
      get    'users/password/new'  => 'devise/passwords#new',        as: :new_user_password
      post   'users/password/edit' => 'devise/passwords#edit',       as: :edit_user_password
      patch  'users/password'      => 'devise/passwords#update'
      post   'users/password'      => 'devise/passwords#create'
      post   'users/guest_login'   => 'devise/sessions#guest_login'
    end

    root to: 'homes#top'
    get  '/home'      => 'homes#home'
    get  '/setting'   => 'homes#setting'
    get  '/help'      => 'homes#help'
    get  '/contact'   => 'homes#contact'
    post '/send/mail' => 'homes#send_mail'

    get '/search/user'    => 'searches#user'
    get '/search/recruit' => 'searches#recruit'

    resources :users, param: :nickname, only: [:update] do
      collection do
        delete 'withdraw'
        get    'search', 'unsubscribe'
      end
      member do
        get '/'             => 'users#show', as: :profile
        get '/profile_edit' => 'users#edit', as: :profile_edit
        get 'schedule', 'followings', 'followers'
      end
      resource :relationships, only: [:create, :destroy]
      resources :evaluations, only: [:new, :index, :create, :destroy]
    end

    resources :recruits, except: [:index] do
      collection do
        get 'schedule'
        get 'schedule/today' => 'recruits#today'
        get 'schedule/week'  => 'recruits#week'
        get 'schedule/month' => 'recruits#month'
      end
      resources :recruit_comments, only: [:edit, :update, :create, :destroy]
      resource :reserves, only: [:create, :destroy] do
        collection do
          get 'waiting', 'confirm', 'complete'
        end
      end
    end
    get '/evaluations' => 'evaluations#other_index', as: :other_user_evaluations
    get '/evaluations/search' => 'evaluations#search'
    resources :evaluations, only: [:show]
    resources :reserves, only: [:update]
    resources :notifications, only: [:index, :destroy]
    resources :messages, only: [:create, :destory, :index, :show]
  end
end