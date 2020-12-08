# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include DeviseHelper

  def create
    @user = User.new(user_params)
    if verify_rucaptcha?(@user) && @user.save
      yield @user if block_given?
      if @user.persisted?
        if @user.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(@user_name, @user)
          respond_with @user, location: after_sign_up_path_for(@user)
        else
          set_flash_message! :notice, :"signed_up_but_#{@user.inactive_message}"
          expire_data_after_sign_in!
          respond_with @user, location: after_inactive_sign_up_path_for(@user)
        end
      else
        clean_up_passwords @user
        set_minimum_password_length
        respond_with @user
      end
    else
      clean_up_passwords @user
      render :new
    end
  end

end
