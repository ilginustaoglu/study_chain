# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # Email verification disabled for now
  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   
  #   # Check if user's email is verified
  #   unless resource.confirmed?
  #     sign_out(resource)
  #     flash[:alert] = "⚠️ Please verify your email address before signing in. We've sent a verification code to your email."
  #     redirect_to new_verification_path(email: resource.email) and return
  #   end
  #   
  #   set_flash_message!(:notice, :signed_in)
  #   sign_in(resource_name, resource)
  #   yield resource if block_given?
  #   respond_with resource, location: after_sign_in_path_for(resource)
  # end
end

