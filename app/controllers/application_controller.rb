class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  before_action :configure_permitted_parameters, if: :devise_controller?

  def access_denied(_exception = nil)
    redirect_to admin_tickets_path, alert: I18n.t('access_denined')
  end

  def after_sign_in_path_for(resource)
    # NOTE: 現状ログイン機能はadminサイトのみのため、ログイン後は決め打ちでdashboardへ飛ばす
    admin_root_path
  end

  def render_404
    if current_user.present?
      redirect_to admin_root_path and return
    else
      redirect_to 'https://www.google.co.jp' and return
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :admin])
    end
end
