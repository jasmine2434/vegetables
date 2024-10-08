Rails.application.routes.draw do

  namespace :admin do
    root to: "homes#top"
    resources :vegetables, only: [:index, :show, :destroy]
    resources :genres, only: [:index, :new, :create, :edit, :update]
    resources :users, only: [:index, :show]
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

    resources :users, only: [:show, :edit, :update, :destroy]

    resources :vegetables, only: [:new, :create, :edit, :update, :show, :index, :destroy] do
      resource :favorite, only: [:create, :destroy, :update]
    end

    resources :profile_image


  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
