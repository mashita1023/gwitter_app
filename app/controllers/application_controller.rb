class ApplicationController < ActionController::Base
    # protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :current_user

    def current_user
        return unless session[:user_id]
        @current_user ||= User.find(session[:user_id])
    end
protected

    def configure_permitted_parameters
        added_attrs = [ :name, :email, :password, :password_confirmation ]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end
end
