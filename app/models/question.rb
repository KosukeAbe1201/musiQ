class Question < ApplicationRecord
  validates :num, { presence: true, length:{ minimum: 1 } }
  belongs_to :user
end
