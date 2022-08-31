class User < ApplicationRecord
  belongs_to :user, optional: true
  has_many :lists
  has_many :questions
  has_many :achieved_lists
  has_many :advices
  has_many :congrats, dependent: :destroy
  has_one_attached :image
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
