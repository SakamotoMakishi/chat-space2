class Notification < ApplicationRecord
  default_scope->{order(created_at: :desc)}
  belongs_to :visiter, class_name: 'User'
  belongs_to :visited, class_name: 'User'
  belongs_to :post, optional: true
  belongs_to :group, optional: true
end
