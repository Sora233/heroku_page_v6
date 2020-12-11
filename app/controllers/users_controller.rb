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

end
