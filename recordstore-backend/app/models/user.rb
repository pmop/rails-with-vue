class User < ApplicationRecord
  has_secure_password
  has_many :records
  validates :email, :password, presence: true, confirmation: true
end
