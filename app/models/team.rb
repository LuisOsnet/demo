class Team < ApplicationRecord
  belongs_to :account
  has_many :users
  has_many :tracks, as: :trackable
  has_paper_trail
  validates :name, presence: true, length: { maximum: 50 }
  validates :account_id, presence: true

end
