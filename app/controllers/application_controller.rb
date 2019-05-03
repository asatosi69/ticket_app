class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def access_denied(_exception = nil)
    redirect_to admin_tickets_path, alert: I18n.t('access_denined')
  end

  def after_sign_in_path_for(resource)
    # NOTE: 現状ログイン機能はadminサイトのみのため、ログイン後は決め打ちでdashboardへ飛ばす
    admin_root_path
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :admin])
    end
end
