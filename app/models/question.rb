class Question < ApplicationRecord
  has_one :category
  belongs_to :user
  has_many :advices

  validates :title, presence: true, length: { maximum: 32 }
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true
end
