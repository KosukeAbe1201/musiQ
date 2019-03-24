class User < ApplicationRecord
  has_secure_password
  validates :name, { presence: true, uniqueness: true }
  validates :password, { presence: true, length:{ minimum: 8 } }
  has_many :posts, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_one :keyword, dependent: :destroy
  has_one :artist, dependent: :destroy
  has_one :question, dependent: :destroy
end
