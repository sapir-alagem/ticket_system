class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { user: 0, admin: 1 }

  has_secure_token :authentication_token
  has_many :tickets

  def self.valid_credentials?(email, password)
    user = find_by(email: email)
    user&.valid_password?(password) ? user : nil
  end
end
