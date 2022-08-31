class AchievedList < ApplicationRecord
  belongs_to :user
  has_one :category
  has_many :congrats, dependent: :destroy
  has_one_attached :image

  def congrated?(user)
    congrats.where(user_id: user.id).exists?
  end

  validates :title, presence: true
  validates :report, presence: true
  validates :category_id, presence: true
  validates :public, inclusion: { in: [true, false] }
  validates :achieved_date, presence: true
end
