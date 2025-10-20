class UserMailer < ApplicationMailer
  default from: 'StudyChain <ilginustaolgu@gmail.com>'

  def verification_code(user)
    @user = user
    @code = user.verification_code
    
    mail(
      to: user.email,
      subject: '🔐 Your StudyChain Verification Code'
    )
  end
end
