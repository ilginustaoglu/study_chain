class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  # Role enum: normal users have limited access, premium users have full access, admin has all permissions
  enum :role, { normal: 0, premium: 1, admin: 2 }

  # Associations
  has_many :tasks, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :timers, dependent: :destroy
  has_many :study_materials, dependent: :destroy
  has_many :flashcard_collections, dependent: :destroy
  has_many :reminders, dependent: :destroy
  has_many :agendas, dependent: :destroy

  # Callbacks
  after_create :create_default_timer

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

  # Persistent session methods
  def enable_persistent_session!
    update(persistent_session: true)
  end

  def disable_persistent_session!
    update(persistent_session: false)
  end

  def has_persistent_session?
    persistent_session
  end

  # Override Devise timeout check - don't timeout if persistent_session is enabled
  def timeout_in
    if has_persistent_session?
      nil  # Never timeout
    else
      30.minutes  # Default timeout for non-persistent sessions
    end
  end

  private

  # Create default timer for new users
  def create_default_timer
    timers.create!(
      name: 'Ders Çalışma',
      seconds: 0,
      break_seconds: 0,
      is_running: false,
      active_timer: 'study'
    )
  end
end
