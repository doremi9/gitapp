class PullRequest < ApplicationRecord
  belongs_to :repository
  has_many   :comments
end