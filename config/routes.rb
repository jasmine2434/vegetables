Rails.application.routes.draw do
  
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  devise_for :admin, skip: [:registrations, :passowrds], controllers: {
    sessions: "admin/sessions"
  }


  scope module: :public do
    root to: 'homes#top'
    #get '/about' => 'homes:about', as: 'about'
    get '/users/my_page' => 'users#mypage' ,as: 'my_page'
    
  resources :users, only: [:index, :show, :edit, :update]
  
  resources :vegetables do
    resource :favorite, only: [:create, :destroy, :update]
  end

  resources :profile_image
    
  end






  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
