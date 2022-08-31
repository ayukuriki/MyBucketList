class List < ApplicationRecord
  belongs_to :user
  has_one :category

  validates :title, presence: true, length: { maximum: 16 }
  validates :category_id, presence: true
  validates :target_year, presence: true, numericality: true
  validates :description, length: { maximum: 30 }
  validates :public, inclusion: { in: [true, false] }
end
