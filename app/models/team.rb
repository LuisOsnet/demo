class Team < ApplicationRecord
  belongs_to :account
  has_many :users
  has_paper_trail
end
