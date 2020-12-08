# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include DeviseHelper

  # before_action :configure_sign_in_params, only: [:create]
  prepend_before_action :valify_captcha!, only: [:create]

  def valify_captcha!
    @user = User.new(user_params)
    unless verify_rucaptcha?
      render :new, alert: t('rucaptcha.invalid')
      return
    end
    true
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
