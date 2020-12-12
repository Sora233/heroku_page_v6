module ApplicationHelper
  def do_paginate(scope)
    scope&.page(params[Kaminari.config.param_name]&.to_i)
      &.per(params[Kaminari.config.default_per_page]&.to_i)
  end

  def flash_resource(resource)
    flash.alert = resource.errors.full_messages.to_sentence
  end

  def flash_resource_now(resource)
    flash.now.alert = resource.errors.full_messages.to_sentence
  end

  def flash_class(level)
    case level
    when 'notice' then
      "alert alert-dismissable alert-info"
    when 'success' then
      "alert alert-dismissable alert-success"
    when 'error' then
      "alert alert-dismissable alert-danger"
    when 'alert' then
      "alert alert-dismissable alert-danger"
    else
      "alert alert-dismissable alert-info"
    end
  end

  def current_request?(*requests)
    controller_name = controller.controller_name.to_s
    action_name = controller.action_name.to_s
    requests.each do |request|
      if request[:controller].to_s == controller_name
        unless (request[:except].is_a?(Array) && request[:except].map(&:to_s).include?(controller_name)) || (request[:except].to_s == action_name)
          return true if request[:action].nil?
          return true if request[:action].is_a?(Array) && request[:action].map(&:to_s).include?(controller_name)
          return true if request[:action].to_s == controller_name || request[:action].to_s == '*'
        end
      end
    end
    false
  end

end
