class PullRequest < ApplicationRecord
  belongs_to :repository
  has_many   :comments

# Overwriting existing method PullRequest.open would not be appropriate here hence creating scope "active" instead
  scope :active, -> { where(state: "open"  ) }
  scope :closed, -> { where(state: "closed") }
end