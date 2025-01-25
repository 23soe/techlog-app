class TagsController < ApplicationController
    def posts_by_tag
      @tag = Tag.find_by(name: params[:tag])
      if @tag
        @posts = @tag.posts.includes(:category, :tags).order(created_at: :desc)
        render json: @posts.as_json(include: { tags: { only: :name }, category: { only: :name } })
      else
        render json: { error: 'Tag not found' }, status: 404
      end
    end
  end
  