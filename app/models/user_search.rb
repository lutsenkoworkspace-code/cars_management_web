class UserSearch < ApplicationRecord
  belongs_to :user

  serialize :query_params, coder: JSON

  validates :name, presence: true
end
