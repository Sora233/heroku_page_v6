module DeviseHelper
  def devise_error_messages!
    if resource.errors.full_messages.any?
      flash.now[:error] = resource.errors.full_messages
    end
    ''
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :remember_me)
  end

end
