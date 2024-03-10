Rails.application.routes.draw do
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # ユーザー用
  # URL /user/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  namespace :admin do
    get 'comments/index'
    get 'users/index'
    get 'homes/top'
  end
  get 'users/edit'
  get 'users/show'
  resources :books, only: [:index, :new, :edit, :update, :create]
  root to: 'homes#about'
  get 'homes/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
