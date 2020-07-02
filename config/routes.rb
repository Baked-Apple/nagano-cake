Rails.application.routes.draw do
  namespace :public do
    get 'orders/index'
    get 'orders/show'
    get 'orders/confirm'
    get 'orders/create'
    get 'orders/thanks'
  end
  devise_for :admins
  devise_for :members
  namespace :admin do
    get 'home/top'
  end
  namespace :public do
    get 'home/top'
    get 'home/about'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
