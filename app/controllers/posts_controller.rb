class PostsController < ApplicationController
  before_action :authenticate_user!, :set_categories, except: [:show, :index]

  def new
    @post = Post.new
    @tags = Tag.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = '投稿しました'
      redirect_to root_path # 一時的にトップページへリダイレクト(要修正)
    else
      flash[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @categories = Category.all
    @tags = Tag.all
  end

  def index
    @posts = Post.includes(:category, :tags).order(created_at: :desc).limit(10)
    @categories = Category.all
    @tags = Tag.all
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.user == current_user
      @post.destroy
      flash[:notice] = '投稿が削除されました'
    end
    redirect_to root_path
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.user == current_user
      if @post.update(post_params)
        flash[:notice] = '投稿が編集されました'
        redirect_to root_path
      else
        flash[:alert] = '投稿の編集に失敗しました'
        render :edit
      end
    else
      flash[:alert] = '編集権限がありません'
      redirect_to root_path
    end
  end

  private

  def set_categories
    @categories = Category.all
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id, tag_ids: [])
  end
end
