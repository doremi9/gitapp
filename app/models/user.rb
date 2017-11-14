class User < ApplicationRecord
  has_many :organizations
  has_many :repositories
  has_many :pull_requests
end