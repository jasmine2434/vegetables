Rails.application.routes.draw do

  namespace :admin do
    get "homes/top" => 'homes#top', as: 'admin/top'
    get '/search' => 'searches#search'
    resources :users, only: [:index, :show, :destroy]
    resources :vegetables, only: [:index, :show, :destroy]
    resources :genres, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :groups, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :show, :destroy]
  end

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passowrds], controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    get '/users/my_page' => 'users#mypage' ,as: 'my_page'
    get '/search' => 'searches#search'


    resources :groups do
      resource :group_users, only: [:create, :destroy]
    end

    resources :users, only: [:show, :edit, :update, :destroy] do
      member do
        get :favorites
      end
    end

    resources :vegetables do
      resource :favorite, only: [:create, :destroy, :update]
      resources :comments, only: [:create, :destroy]
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
