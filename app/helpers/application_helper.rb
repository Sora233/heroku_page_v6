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

end
