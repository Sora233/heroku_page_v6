class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  load_and_authorize_resource

  def index
    @posts = do_paginate(@posts).opened.natural_order
  end

  def show
    @post.do_visit unless !current_user.nil? && @post.user_id == current_user&.id
    @comments = @post.comments.includes(:user).natural_order
  end

  def new; end

  def create
    if @post.save
      redirect_to @post
    else
      flash_resource_now @post
      render :new
    end
  end

  def edit; end

  def update
    @post.attributes = post_params
    if @post.save
      flash[:notice] = t("post.update.success")
      redirect_to @post
    else
      flash_resource_now @post
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = t("post.delete.success")
      redirect_to action: :index
    else
      flash_resource @post
      redirect_back fallback_location: @post
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :published)
  end
end
