class Congrat < ApplicationRecord
  belongs_to :user
  belongs_to :achieved_list
end
