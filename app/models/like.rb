class Like < ApplicationRecord
  belongs_to :post, counter_cache: :likes_count
  belongs_to :user
end
