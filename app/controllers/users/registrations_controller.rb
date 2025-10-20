# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]

  def create
    # Email verification disabled - using standard Devise flow
    super
    
    # Old verification code (disabled for now)
    # build_resource(sign_up_params)
    # resource.validate
    # if resource.errors.any?
    #   clean_up_passwords resource
    #   set_minimum_password_length
    #   respond_with resource
    #   return
    # end
    # resource.save
    # if resource.persisted?
    #   resource.generate_verification_code
    #   begin
    #     UserMailer.verification_code(resource).deliver_now
    #   rescue => e
    #     Rails.logger.error "Email sending failed: #{e.message}"
    #   end
    #   set_flash_message! :notice, :signed_up_but_unconfirmed
    #   redirect_to new_verification_path(email: resource.email)
    # else
    #   clean_up_passwords resource
    #   set_minimum_password_length
    #   respond_with resource
    # end
  end

  private

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      resource.validate # Look for any other validation errors besides reCAPTCHA
      set_minimum_password_length
      respond_with_navigational(resource) do
        flash.discard(:recaptcha_error) # We need to discard flash to avoid showing it on the next page
        flash.now[:alert] = "reCAPTCHA verification failed, please try again."
        render :new
      end
    end
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end

