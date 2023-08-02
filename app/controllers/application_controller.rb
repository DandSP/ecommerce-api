class ApplicationController < ActionController::API
    before_action :configure_permited_parameters, if: :devise_controller?
    protected
        
    def configure_permited_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
    end
end
