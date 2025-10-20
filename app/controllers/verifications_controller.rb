class VerificationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:verify]
  
  def new
    @email = params[:email]
    redirect_to root_path unless @email.present?
  end

  def verify
    email = params[:email]
    code = params[:code]
    
    user = User.find_by(email: email)
    
    if user.nil?
      flash[:alert] = "User not found."
      redirect_to new_user_registration_path and return
    end
    
    if user.confirmed?
      flash[:notice] = "Your account is already verified. Please log in."
      redirect_to new_user_session_path and return
    end
    
    if user.verify_with_code!(code)
      flash[:notice] = "✅ Your email has been successfully verified! Welcome to StudyChain. Please log in."
      redirect_to new_user_session_path
    else
      flash.now[:alert] = "❌ Invalid or expired verification code. Please try again or request a new code."
      @email = email
      render :new
    end
  end

  def resend
    email = params[:email]
    user = User.find_by(email: email)
    
    if user.nil?
      flash[:alert] = "User not found."
      redirect_to new_user_registration_path and return
    end
    
    if user.confirmed?
      flash[:notice] = "Your account is already verified. Please log in."
      redirect_to new_user_session_path and return
    end
    
    user.generate_verification_code
    UserMailer.verification_code(user).deliver_now
    
    flash[:notice] = "📧 A new verification code has been sent to your email."
    redirect_to new_verification_path(email: email)
  end
end

