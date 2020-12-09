module ApplicationHelper
  def do_paginate(scope)
    scope&.page(params[Kaminari.config.param_name]&.to_i)
      &.per(params[Kaminari.config.default_per_page]&.to_i)
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
    requests.each do |request|
      if request[:controller].to_s == controller.controller_name.to_s
        return true if request[:action].nil?
        return true if request[:action].is_a?(Array) && request[:action].map(&:to_s).include?(controller.action_name.to_s)
        return true if request[:action].to_s == controller.action_name.to_s || request[:action].to_s == '*'
      end
    end
    false
  end

end
