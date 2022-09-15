class Category < ApplicationRecord
  belongs_to :list
  belongs_to :question
  belongs_to :achieved_list
end
