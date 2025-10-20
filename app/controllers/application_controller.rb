class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # Redirect to landing page after logout
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  # Authorization helpers
  def require_admin
    unless current_user&.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end

  def require_premium_or_admin
    unless current_user&.premium? || current_user&.admin?
      flash[:alert] = "This feature is only available for premium members."
      redirect_to root_path
    end
  end

  def require_authenticated_user
    unless user_signed_in?
      flash[:alert] = "You need to sign in to access this page."
      redirect_to new_user_session_path
    end
  end
end
