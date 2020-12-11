class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource

  def index
    @users = do_paginate(@users).order(:created_at)
  end

  def disable
    @user.disabled!
    redirect_back fallback_location: @user
  end

  def enable
    @user.enabled!
    redirect_back fallback_location: @user
  end

  private

  def authenticate_admin!
    current_user.require_admin!
  end
end
