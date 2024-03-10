class ApplicationController < ActionController::Base
  # userと管理者でログイン後の遷移先の指定
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when User
      root_path
    else
      root_path
    end
  end
end
