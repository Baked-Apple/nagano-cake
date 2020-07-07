Rails.application.routes.draw do

  devise_for :members, controllers:{
    sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations'
  }

  devise_for :admins, controllers:{
    sessions: 'admin/sessions',
    passwords: 'admin/passwords',
    registrations: 'admin/registrations'
  }

  namespace :public do
    get 'top' => 'home#top'
    get 'about' => 'home#about'
    get 'confirm' => 'members#confirm'
    put 'confirm' => 'members#hide'
    get 'mypage' => 'members#show'
    get 'mypage/edit' => 'members#edit'
    patch 'mypage' => 'members#update'
    get 'orders/confirm' => 'orders#confirm'
    get 'orders/thanks' => 'orders#thanks'
  	resources :orders, only: [:new, :index, :show, :create]
    resources :items, only: [:index, :show, :create] 
    resources :cart_items, only: [:index, :create, :update, :destroy]
    
    
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
  end

  namespace :admin do
    get 'top' => 'home#top'
    resources :orders, only: [:index, :show, :update]
    patch 'order_items/:id' => 'order_items#update'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :members, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
