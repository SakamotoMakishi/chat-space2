class Retweet < ApplicationRecord
  belongs_to :post, counter_cache: :retweets_count
  belongs_to :user
end
