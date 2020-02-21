class User < ApplicationRecord
  attr_accessor :remember_token

  validates :name, presence: true,
    length: {maximum: Settings.user.name_maximum_length}
  validates :email, presence: true,
    length: {maximum: Settings.user.email_maximum_length},
    format: {with: Settings.user.email_regex_string},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.user.password_minimum_length},
    allow_nil: true
  before_save{email.downcase!}
  has_secure_password
  
  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false unless remember_digest
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attribute :remember_digest, nil
  end
end
