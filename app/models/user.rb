# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :email, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validate :valid_email_format
  after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(attrs)
    user = User.find_by(email: attrs[:email])
    return nil if user.nil?
    return user.is_password?(attrs[:password]) ? user : nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    save!
    session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  private

  def valid_email_format
    unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors[:email] << "is not a valid email"
    end
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
