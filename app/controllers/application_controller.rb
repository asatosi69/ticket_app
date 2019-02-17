class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def access_denied(_exception = nil)
    redirect_to admin_tickets_path, alert: I18n.t('access_denined')
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :admin])
    end
end
