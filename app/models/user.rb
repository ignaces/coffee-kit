# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  first_name      :string(255)
#  last_name       :string(255)
#  is_active       :boolean          default(TRUE)
#  is_admin        :string(255)      default("f")
#  created_at      :datetime
#  updated_at      :datetime
#  remember_token  :string(255)
#

class User < ActiveRecord::Base

  has_secure_password
  has_many :shipping_addresses
  has_many :subscriptions

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, presence: true
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

  before_create :create_remember_token
  before_save { self.email = email.downcase }

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def active_subscription
    subscriptions.active.includes(subscription_months: :shipment).order(:created_at).last
  end

  def send_password_reset_email
    create_password_recovery_token
    PasswordResetMailer.reset_password(self).deliver
  end

  def reset_password(password)
    self.password = password
    self.password_confirmation = password
    save
    create_remember_token
    true
  end

  private

    def create_remember_token
      self.remember_token = Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64)
    end

    def create_password_recovery_token
      begin
        self.password_recovery_token = SecureRandom.hex(30)
      end while User.exists?(password_recovery_token: password_recovery_token)
      save
    end


end
