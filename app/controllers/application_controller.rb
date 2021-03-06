class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	# Check authorization for every action, unless its made by a devise model
	before_action :configure_permitted_parameters, if: :devise_controller?
	check_authorization unless: :devise_controller?
	# Handle 'access denied' exception redirecting the user to the home page
	rescue_from CanCan::AccessDenied do |exception|
		redirect_to root_url, notice: exception.message
	end

	protected
		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :name, :email, :password, :password_confirmation, :remember_me) }
			devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
			devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :username, :name, :phone, :birthday, :sex, :country, :state, :city, :work, :education, :profile_picture) }
		end
end