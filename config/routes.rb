Rails.application.routes.draw do

root to: 'public/homes#top'
get '/search', to: 'search#action_name', as: 'search'

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    resources :posts, only: [:index, :show, :destroy]
    resources :customers, only: [:index,:show,:edit,:update] do
      resource :relationships, only: [:create, :destroy]
    	get "followings" => "relationships#followings", as: "followings"
    	get "followers" => "relationships#followers", as: "followers"
    	member do
        get :favorites
       end
    end

    get "search" => "searches#search"
  end

# 顧客用
# URL /customers/sign_in ...
devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  namespace :public do

  devise_scope :customer do
    post "customers/guest_sign_in", to: "customers/sessions#guest_sign_in"
    get 'customers/confirm/:id', to: 'customers#confirm'
    patch 'customers/unsubscribe', to: 'customers#unsubscribe', as: 'customers/unsubscribe'
  end

  resources :posts, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  resources :customers, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
  	get "followings" => "relationships#followings", as: "followings"
  	get "followers" => "relationships#followers", as: "followers"
  	member do
      get :favorites
     end
  end

  get "search" => "searches#search"
  end

end