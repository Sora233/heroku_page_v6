# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  include DeviseHelper
  prepend_before_action :valify_captcha!, only: [:create]

  def valify_captcha!
    unless verify_rucaptcha?
      flash_alert t("rucaptcha.invalid")
      redirect_to action: :new
      return
    end
    true
  end
end
