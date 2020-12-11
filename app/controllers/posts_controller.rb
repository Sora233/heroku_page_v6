class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  load_and_authorize_resource

  def index
    @posts = do_paginate(@posts).opened
  end

  def show
    @post.do_visit
  end

  def new; end

  def create
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit; end

  def update
    @post.attributes = post_params
    if @post.save
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy; end

  private

  def post_params
    params.require(:post).permit(:title, :content, :published, :public)
  end
end
