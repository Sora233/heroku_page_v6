class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  load_and_authorize_resource

  def show
  end

  def edit
  end

  def update
    unless verify_rucaptcha?(@user)
      flash_alert_now t('rucaptcha.invalid')
      return render :edit
    end
    @user.attributes = user_params

    unless @user.changed?
      return redirect_to action: :show
    end

    if @user.save
      @user.reload
      if @user.pending_reconfirmation?
        flash_notice t('user.update.success')
        sign_out @user
      end
      redirect_to action: :show
    else
      flash_resource_now @user
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash_notice t("user.destroy.success")
      redirect_to root_path
    else
      flash_resource_now @user
      render :show
    end
  end

  def user_params
    params.require(:user).permit(:email)
  end

end
