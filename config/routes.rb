Rails.application.routes.draw do
  get 'chats/show'
  get 'searches/search' => "searches#search", as: "search"
  get 'books/ranking' => "books#ranking", as: "ranking"
  devise_for :users#, controllers: {registrations: 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get "home/about" => "homes#about", as: "about"
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  resources :chats, only: [:show, :create]


end
