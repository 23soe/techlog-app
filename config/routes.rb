Rails.application.routes.draw do
  get 'categories/new'
  devise_for :users
  root 'posts#index'
  
  resources :posts, only: [:new, :create, :show, :destroy, :edit, :update]
  resources :categories, only: [:index, :show]
  resources :tags, only: [] do
    collection do
      get :posts_by_tag
    end
  end
end
