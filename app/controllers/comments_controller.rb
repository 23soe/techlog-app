class CommentsController < ApplicationController
    before_action :set_post, only: [:create, :destroy]
  
    def create
      @comment = @post.comments.build(comment_params)
      if @comment.save
        redirect_to @post, notice: 'コメントが追加されました。'
      else
        redirect_to @post, alert: 'コメントを保存できません。'
      end
    end
  
    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to @comment.post, notice: 'コメントが削除されました。'
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  