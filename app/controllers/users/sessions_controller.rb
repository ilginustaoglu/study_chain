# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # Handle remember me checkbox and persistent session
  def create
    self.resource = warden.authenticate!(auth_options)
    
    # Handle persistent session based on remember_me checkbox
    if params[:user] && params[:user][:remember_me] == '1'
      resource.enable_persistent_session!
    else
      resource.disable_persistent_session!
    end
    
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # Clear persistent session on logout
  def destroy
    if current_user
      current_user.disable_persistent_session!
    end
    super
  end

  # Check if user should timeout (only if persistent_session is false)
  def check_timeout
    return unless current_user
    return if current_user.has_persistent_session?
    
    # Call the original Devise timeout check
    super if defined?(super)
  end
end

