class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  load_and_authorize_resource

  def show
  end

  def update
  end

  def delete
  end

  def destroy
  end

  def disable
    @user.disabled!
    redirect_back fallback_location: @user
  end

  def enable
    @user.enabled!
    redirect_back fallback_location: @user
  end
end
