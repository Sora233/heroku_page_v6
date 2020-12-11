class Profile::PostsController < ApplicationController
  def index
    @posts = do_paginate(current_user.posts)
  end
end
