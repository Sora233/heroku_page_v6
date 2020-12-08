class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  load_and_authorize_resource

  def index
    @users = do_paginate(@users).order(:created_at)
  end

  private

  def authenticate_admin!
    current_user.require_admin!
  end
end
