class TagsController < ApplicationController
    def posts_by_tag
      @tag = Tag.find_by(name: params[:tag])
      if @tag
        @posts = @tag.posts.includes(:category, :tags).order(created_at: :desc)
        render json: @posts.as_json(include: { tags: { only: :name }, category: { only: :name } })
      else
        render json: [], status: :ok
      end
    end

    def posts_by_tag_or_category
      query = CGI.unescape(params[:query]) # URLデコード
      @tag = Tag.find_by(name: query)
      @category = Category.find_by(name: query)
  
      if @tag
        @posts = @tag.posts.includes(:category, :tags).order(created_at: :desc)
        render json: @posts.as_json(include: { tags: { only: :name }, category: { only: :name } })
      elsif @category
        @posts = @category.posts.includes(:tags).order(created_at: :desc)
        render json: @posts.as_json(include: { tags: { only: :name }, category: { only: :name } })
      else
        render json: [], status: :ok 
      end
    end
  end
  