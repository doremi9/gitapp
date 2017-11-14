class PullRequest < ApplicationRecord
  belongs_to :repository
  has_many   :comments
  belongs_to :user
end