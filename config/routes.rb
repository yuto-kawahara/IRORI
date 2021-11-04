Rails.application.routes.draw do
  devise_for :users, skip: :all
  devise_scope :user do
    get    'users/login'         => 'devise/sessions#new',        as: :new_user_session
    post   'users/login'         => 'devise/sessions#create',     as: :user_session
    delete 'users/logout'        => 'devise/sessions#destroy',    as: :destory_user_session
    get    'users/signup'        => 'devise/registrations#new',   as: :new_user_registration
    post   'users/signup'        => 'devise/registrations#create',as: :user_registration
    get    'users/password/new'  => 'devise/passwords#new',       as: :new_user_password
    post   'users/password/edit' => 'devise/passwords#edit',      as: :edit_user_password
    patch  'users/password'      => 'devise/passwords#update'
    post   'users/password'      => 'devise/passwords#create'

  end
  scope module: :user do
    root to: 'homes#top'
    get '/home'    => 'homes#home'
    get '/setting' => 'homes#setting'
    get '/help'    => 'homes#help'
    get '/contact' => 'homes#contact'

    resources :users, param: :nickname, only: [:update] do
      member do
        get    '/'             => 'users#show', as: :profile
        get    '/profile_edit' => 'users#edit', as: :profile_edit
        get    'reserve', 'schedule', 'followings', 'followers'
      end
      collection do
        delete 'withdraw'
        get    'unsubscribe'
      end
      resource :relationships, only: [:create, :destroy]
    end

    resources :recruits do
      collection do
        get  'schedule'
      end
      resources :recruit_comments, only: [:edit, :update, :create, :destroy]
      resource :reserves, only: [:create, :destroy] do
        collection do
          get 'reserve_list', 'confirm', 'complete'
        end
      end
    end
    resources :reserves, only: [:update]
    resources :notifications, only: [:index]
    resources :messages, only: [:create, :destory, :index, :show]
  end
end
