Rails.application.routes.draw do
  get 'categories/new'
  devise_for :users
  root 'posts#index'
  
  resources :posts, only: [:new, :create, :show, :destroy, :edit, :update] do
    resources :comments, only: [:create, :destroy]
  end
  resources :categories, only: [:index, :show]
  resources :tags, only: [:show] do
    collection do
      get :posts_by_tag_or_category
    end
  end
end
