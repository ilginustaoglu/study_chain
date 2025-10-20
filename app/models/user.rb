class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Role enum: normal users have limited access, premium users have full access, admin has all permissions
  enum role: { normal: 0, premium: 1, admin: 2 }

  # Validations
  validates :name, presence: true

  # Verification code methods
  def generate_verification_code
    self.verification_code = rand(100000..999999).to_s
    self.verification_code_sent_at = Time.current
    save(validate: false)
  end

  def verification_code_valid?(code)
    return false if verification_code.blank? || code.blank?
    return false if verification_code_sent_at.nil?
    return false if verification_code_sent_at < 30.minutes.ago
    
    verification_code == code
  end

  def verify_with_code!(code)
    if verification_code_valid?(code)
      self.confirmed_at = Time.current
      self.verification_code = nil
      self.verification_code_sent_at = nil
      save(validate: false)
      true
    else
      false
    end
  end

  def confirmed?
    confirmed_at.present?
  end

  # Helper methods for role checking
  def admin?
    role == 'admin'
  end

  def premium?
    role == 'premium'
  end

  def normal?
    role == 'normal'
  end
end
