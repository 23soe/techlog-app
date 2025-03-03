class CategoriesController < ApplicationController
  def index
    categories = Category.all
    render json: categories
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts
  end
end
