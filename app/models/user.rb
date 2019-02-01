class User < ApplicationRecord
  has_secure_password

  has_many :accounts, foreign_key: :owner_id
  has_many :contacts
end
