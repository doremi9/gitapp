class Repository < ApplicationRecord
  belongs_to :organization
  belongs_to :user
  has_many   :pull_requests
end
