class CommentsController < ApplicationController
  load_and_authorize_resource :post
  load_and_authorize_resource :comment, through: :post

  def create
    @comment.user = current_user
    unless @comment.save
      flash_resource_now @comment
    end
    redirect_back fallback_location: post_path(@post)

  end

  def destroy

  end

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
