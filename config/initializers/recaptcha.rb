# reCAPTCHA Configuration
Recaptcha.configure do |config|
  # For development, you can use test keys that always pass
  # For production, you need to get real keys from https://www.google.com/recaptcha/admin
  
  # Test keys (always pass in development)
  config.site_key   = ENV['RECAPTCHA_SITE_KEY'] || '6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI'
  config.secret_key = ENV['RECAPTCHA_SECRET_KEY'] || '6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe'
  
  # Optional: Skip verification in test environment
  config.skip_verify_env << 'test' if Rails.env.test?
end

