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

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  get "search" => "searches#search"
  get "search_tag" => "books#search_tag"
  namespace :admin do
    get 'comments' => 'admin#comments'
    get 'users' => 'admin#users'
    get 'tags' => 'admin#tags'
    get 'books' => 'admin#books'
    root to: "admin#top"
  end
  resources :events, only: [:create]
  get 'users/my_page'
  resources :users, only: [:edit, :show, :update, :destroy]
  resources :tags, only: [:destroy]
  resources :books, only: [:index, :new, :edit, :update, :create, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy] do
      post '/favorites' => 'favorites#create_book_comment'
      delete '/favorites' => 'favorites#destroy_book_comment'
    end
  end
  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
