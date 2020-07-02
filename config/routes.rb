Rails.application.routes.draw do
  namespace :admin do
    get 'home/top'
  end
  namespace :public do
    get 'home/top'
    get 'home/about'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
