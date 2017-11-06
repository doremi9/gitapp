class Comment < ApplicationRecord
  belongs_to :pull_request
end
