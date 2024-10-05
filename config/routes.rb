Rails.application.routes.draw do

  namespace :public do
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
  end
  get 'posts/index'
  get 'posts/show'
  get 'posts/edit'
  namespace :public do
    get 'users/mypage'
    get 'users/edit'
    get 'users/show'
  end
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  devise_for :admin, skip: [:registrations, :passowrds], controllers: {
    sessions: "admin/sessions"
  }


  scope module: :public do
    root to: 'homes#top'
    #get '/about' => 'homes:about', as: 'about'
    get '/users/my_page' => 'users#my_page' ,as: 'my_page'
    get '/users/information/edit' => 'users#edit' ,as: 'information_edit'
  end






  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
