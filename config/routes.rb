Rails.application.routes.draw do

root to: 'public/homes#top'
get '/search', to: 'search#action_name', as: 'search'

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end

# 顧客用
# URL /customers/sign_in ...
devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  namespace :public do
    #root 'homes#top'

  resources :posts, only: [:new, :create, :index, :show, :destroy] do
    resources :posts_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :customers, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get "search" => "searches#search"
  end

end