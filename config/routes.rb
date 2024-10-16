Rails.application.routes.draw do

  namespace :admin do
    get "homes/top" => 'homes#top', as: 'admin/top'
    get '/search' => 'searches#search'
    resources :vegetables, only: [:index, :show, :destroy]
    resources :genres, only: [:index, :new, :create, :edit, :update]
    resources :users, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
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



    resources :users, only: [:show, :edit, :update, :destroy] do
      resources :groups, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    end

    resources :vegetables, only: [:new, :create, :edit, :update, :show, :index, :destroy] do
      resource :favorite, only: [:create, :destroy, :update]
      resources :comments, only: [:create, :destroy]
    end

    resources :profile_image


  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
