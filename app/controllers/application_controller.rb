class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # userと管理者でログイン後の遷移先の指定
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when User
      users_my_page_path
    else
      root_path
    end
  end

  private
  # ログインする際に名前も許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:email, :name])
  end
end
