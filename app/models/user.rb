class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name, presence: true,
    length: {maximum: Settings.user.name_maximum_length}
  validates :email, presence: true,
    length: {maximum: Settings.user.email_maximum_length},
    format: {with: Settings.user.email_regex_string},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {minimum: Settings.user.password_minimum_length}
  has_secure_password
end
