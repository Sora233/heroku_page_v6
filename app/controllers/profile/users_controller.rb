class Profile::UsersController < ApplicationController
  load_and_authorize_resource

  def block_index
    @users = current_user.block_users.preload(:roles)
  end

  def block
    current_user.add_block_user @user
    redirect_back fallback_location: block_list_profile_users_path
  end

  def unblock
    current_user.cancel_block_user @user
    redirect_back fallback_location: block_list_profile_users_path
  end
end
